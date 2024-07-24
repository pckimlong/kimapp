// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:kimapp/kimapp.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// export 'state_widget_example.dart';

// part 'state_widget_example.freezed.dart';
// part 'state_widget_example.g.dart';


// @freezed
// class ExampleModel with _$ExampleModel {
//   const ExampleModel._();
//   @TableModel('xxx')
//   const factory ExampleModel(
//     {required  int id, required String name}
// ) = _ExampleModel;

//   factory ExampleModel.fromJson(Map<String, dynamic> json) => _$ExampleModelFromJson(json);

//   static const table = _tableExampleModel;
// }



// @stateWidget
// @riverpod
// String normalValueGenerate(NormalValueGenerateRef ref, String a){
//   return 'test';
// }


// @stateWidget
// @riverpod
// ExampleModel normalGenerate(NormalGenerateRef ref){
//   return ExampleModel(id: 1, name: 'test');
// }

// @stateWidget
// @riverpod
// List<ExampleModel> normalGenerateList(NormalGenerateListRef ref){
//   return [ExampleModel(id: 1, name: 'test')];
// }

// @stateWidget
// @riverpod
// Future<ExampleModel> asyncGenerate(AsyncGenerateRef ref, int hello) async {
//   return ExampleModel(id: 1, name: 'test');
// }
// @stateWidget
// @riverpod
// Future<List<ExampleModel>> asyncListGenerate(AsyncListGenerateRef ref) async {
//   return [ExampleModel(id: 1, name: 'test')];
// }
// @stateWidget
// @riverpod
// Future<IList<ExampleModel>> asyncIListGenerate(AsyncIListGenerateRef ref) async {
//   return [ExampleModel(id: 1, name: 'test')].lock;
// }

// @stateWidget
// @riverpod
// class ClassGenerate extends _$ClassGenerate {
//   @override
//   FutureOr<List<ExampleModel>> build(int param) async {
//     return [ExampleModel(id: 1, name: 'test f')];
//   }
// }

// @stateWidget
// @riverpod
// class ClassGenerate2 extends _$ClassGenerate2 {
//   @override
//   FutureOr<ExampleModel> build(int a) async {
//     return ExampleModel(id: 1, name: 'test f');
//   }
// }

// @stateWidget
// @riverpod
// class ClassGenerate3 extends _$ClassGenerate3 {
//   @override
//   FutureOr<ExampleModel> build(int a, {String b = "Hello"}) async {
//     return ExampleModel(id: 1, name: 'test f');
//   }
// }

