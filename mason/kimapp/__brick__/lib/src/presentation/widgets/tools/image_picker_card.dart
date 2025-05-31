import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';
import 'package:kimapp_utils/kimapp_utils.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/helpers/build_context_helper.dart';
import '../../app/app_style.dart';
import '../components/bouncing_widget.dart';

class ImagePickerCard extends StatefulWidget {
  const ImagePickerCard({
    super.key,
    this.imageFile,
    this.imageObject,
    this.borderRadius = 8,
    this.height = 150,
    this.aspectRatio = 1,
    this.width,
    this.placeholder,
    this.exitMaxSizeMessage = 'Image size exceeds the maximum allowed size.',
    required this.onImageChanged,
    this.pickerTitle = 'Select Image',
    this.allowCompression = false,
    this.isCircle = false,
    this.placeholderTitle = 'Upload Image',
    this.placeholderSubTitle = 'or drag and drop',
    this.placeholderIcon = const Icon(LineIcons.image),
    this.enableDragAndDrop = true,
  }) : assert(aspectRatio != null || width != null);

  final XFile? imageFile;
  final bool enableDragAndDrop;
  final BaseStorageObject? imageObject;

  final double? aspectRatio;

  /// Width of the card, will also use to calculate the initial aspect ratio of cropping if [aspectRatio] is null
  final double? width;

  /// Height of the card, will also use to calculate the initial aspect ratio of cropping if [aspectRatio] is null
  final double height;
  final double borderRadius;
  final Widget? placeholder;
  final String exitMaxSizeMessage;
  final void Function(XFile? file) onImageChanged;
  final String pickerTitle;
  final bool allowCompression;
  final bool isCircle;
  final String placeholderTitle;
  final String placeholderSubTitle;
  final Widget placeholderIcon;

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  late final double _width;
  late final double _aspectRatio;
  bool _dragging = false;
  bool _isHovering = false;

  /// This is used on web
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();

    if (widget.width != null) {
      _width = widget.width!;
    } else {
      _width = widget.aspectRatio! * widget.height;
    }

    if (widget.aspectRatio != null) {
      _aspectRatio = widget.aspectRatio!;
    } else {
      _aspectRatio = _width / widget.height;
    }
  }

  Future<bool> _checkValidImage(XFile imageFile) async {
    // Check file type
    final fileType = FileType.fromPath(imageFile.name);
    if (fileType != FileType.image && !platformType.isWeb) {
      BotToast.showText(text: 'Invalid file type. Please select an image.');
      return false;
    }

    final maxSize = StorageManager.config.typeSpecificMaxSizes[FileType.image];
    if (maxSize != null) {
      final fileSize = await imageFile.length();
      if (fileSize > maxSize) {
        BotToast.showText(text: widget.exitMaxSizeMessage);
        return false;
      }
    }

    return true;
  }

  void _onImagePicked(XFile? file) async {
    if (file == null) return;
    final isValid = await _checkValidImage(file);
    if (!isValid) return;

    XFile resultImage = file;

    if (platformType.isAndroid || platformType.isIos || platformType.isWeb) {
      final cropStyle = widget.isCircle ? CropStyle.circle : CropStyle.rectangle;
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: widget.aspectRatio != null
            ? CropAspectRatio(ratioX: widget.aspectRatio!, ratioY: 1)
            : null,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: widget.pickerTitle,
            toolbarColor: context.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: widget.aspectRatio != null,
            cropStyle: cropStyle,
          ),
          IOSUiSettings(
            title: widget.pickerTitle,
            cropStyle: cropStyle,
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        if (platformType.isWeb) {
          final bytes = await croppedFile.readAsBytes();
          setState(() {
            _imageBytes = bytes;
          });
        }
        resultImage = XFile(
          croppedFile.path,
          name: file.name,
          mimeType: file.mimeType,
        );
      } else {
        return;
      }
    }

    widget.onImageChanged(resultImage);
  }

  Future<XFile?> _pickImage() async {
    try {
      // TODO: Show bottomsheet to choose either gallery or camera
      final result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: widget.allowCompression ? 70 : 100,
      );
      final image = result;

      if (image != null) {
        if (platformType.isWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _imageBytes = bytes;
          });
        }

        return image;
      }
    } catch (e, s) {
      Kimapp.instance.log(LoggerType.error, message: e.toString(), object: e, stackTrace: s);
      BotToast.showText(text: e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return m.Material(
      type: m.MaterialType.transparency,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final height =
              constraints.maxWidth < _width ? constraints.maxWidth / _aspectRatio : widget.height;

          return SizedBox(
            width: _width,
            height: height,
            child: Center(
              child: AspectRatio(
                aspectRatio: _aspectRatio,
                child: BouncingWidget(
                  isEnabled: !_isHovering,
                  child: GestureDetector(
                    onTap: () async {
                      final file = await _pickImage();
                      _onImagePicked(file);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _dragging ? context.colors.outline.withValues(alpha: 0.3) : null,
                        shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
                      ),
                      child: widget.enableDragAndDrop
                          ? DropTarget(
                              onDragDone: (detail) async {
                                _onImagePicked(detail.files.firstOrNull);
                              },
                              onDragEntered: (detail) {
                                setState(() {
                                  _dragging = true;
                                });
                              },
                              onDragExited: (detail) {
                                setState(() {
                                  _dragging = false;
                                });
                              },
                              child: _image(context),
                            )
                          : _image(context),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _image(BuildContext context) {
    if (widget.imageFile != null) {
      return _buildImageBody(context);
    }

    return _buildPlaceholder();
  }

  m.MouseRegion _buildImageBody(m.BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(),
          if (_isHovering && !platformType.isAndroid && !platformType.isIos) ...[
            Container(
              decoration: BoxDecoration(
                color: context.colors.outline.withValues(alpha: 0.3),
                shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: widget.isCircle ? null : BorderRadius.circular(widget.borderRadius),
              ),
            ),
            if (widget.isCircle)
              Center(child: _buildClearButton())
            else
              Positioned(
                top: 4,
                right: 4,
                child: _buildClearButton(),
              ),
          ],
          if (platformType.isAndroid || platformType.isIos)
            Positioned(
              top: 4,
              right: 4,
              child: _buildClearButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildClearButton() {
    return SizedBox(
      height: 30,
      width: 30,
      child: FittedBox(
        child: IconButton(
          onPressed: () {
            widget.onImageChanged(null);
            setState(() {
              _dragging = false;
              _isHovering = false;
              _imageBytes = null;
            });
          },
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildImage() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.outline.withValues(alpha: .5),
          width: 2,
        ),
        shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: widget.isCircle ? null : BorderRadius.circular(widget.borderRadius),
        image: DecorationImage(
          image: platformType.isWeb
              ? MemoryImage(_imageBytes!) as ImageProvider<Object>
              : FileImage(File(widget.imageFile!.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  DottedBorder _buildPlaceholder() {
    return DottedBorder(
      dashPattern: [6, 4],
      color: context.colors.outline.withValues(alpha: 0.8),
      strokeCap: StrokeCap.round,
      borderType: widget.isCircle ? BorderType.Circle : BorderType.RRect,
      radius: Radius.circular(widget.borderRadius),
      padding: EdgeInsets.all(16),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget.placeholder ?? _defaultPlaceholder(),
        ),
      ),
    );
  }

  Widget _defaultPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              size: 32,
              color: context.colors.outline.withValues(alpha: .5),
            ),
            child: widget.placeholderIcon,
          ),
          AS.hGap8,
          Text(
            widget.placeholderTitle,
            style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            widget.placeholderSubTitle,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
