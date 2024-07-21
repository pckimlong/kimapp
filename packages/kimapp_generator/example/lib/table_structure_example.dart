
import 'package:kimapp/annotation.dart';

@TableStructure(
  'samples',
  classPrefixName: 'Sample',
  idColumn: 'SampleId:int',
  additionalClasses: [
    'CreateSampleParam', 
    'UpdateSampleParam',
  ],
  columns: [
    'id:int',
    'name:String[0,1]',
    'description:String?[0,1]',
    'createdAt:DateTime[1]',
    'updatedAt',
  ],
)
const placeHolder = 'It can be anything!'; 
