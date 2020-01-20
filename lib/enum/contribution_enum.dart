enum WhatEnum{
  create,
  receive,
  update,
  delete,
  request,
  accept,
  deny,

}

String getWhatEnumString(WhatEnum whatEnum){
  Map<WhatEnum,String> enumString = {
    WhatEnum.create:"Create",
    WhatEnum.receive:"Receive",
    WhatEnum.update:"Update",
    WhatEnum.delete:"Delete",
    WhatEnum.request:"Request",
    WhatEnum.accept:"Accept",
    WhatEnum.deny:"Deny",
  };
  return enumString[whatEnum];
}

enum WhereEnum{
  groupwork,
  assignment,
  task,
  reference,
  suggestion,
  material,
}

String getWhereEnumString(WhereEnum whereEnum){
  Map<WhereEnum,String> enumString = {
    WhereEnum.groupwork:"Groupwork",
    WhereEnum.assignment:"Assignment",
    WhereEnum.task:"Task",
    WhereEnum.reference:"Reference",
    WhereEnum.suggestion:"Suggestion",
    WhereEnum.material:"Material",
  };
  return enumString[whereEnum];
}