
import 'package:example/state_widget_example.dart';
import 'package:kimapp/annotation.dart';

@TableStructure(
  'samples',
  classPrefixName: 'Sample',
  idColumn: 'SampleId:int',
  additionalClasses: [
    'UpdateSampleParam:table(v_sample)[address:int, ex:ExampleModel(example_id)]',
  ],
  columns: [
    'id:SampleId[0]',
    'name:String[0,1]',
    'description:String?[0,1]',
    'createdAt:DateTime[1]',
    'updatedAt:DateTime[0,1]',
    'ids:List<int>[0,1]',
    'good',
  ],
  generateRawClass: true,
  rawClassTableMode: true,
  customTypes: [
    ExampleModel,
  ],
)
const placeHolder = 'It can be anything!'; 
