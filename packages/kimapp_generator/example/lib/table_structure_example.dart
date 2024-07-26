import 'package:kimapp/annotation.dart';

@TableStructure(
  'samples',
  classPrefixName: 'Sample',
  idColumn: 'SampleId:int',
  columns: [
    'id',
    'name',
    'description',
  ],
)
const placeHolder = 'It can be anything!';
