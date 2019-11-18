
enum WhatEnum{
  create,
  receive,
  update,
  delete,
  request,
}

String getWhatEnumString(WhatEnum whatEnum){
  Map<WhatEnum,String> enumString = {
    WhatEnum.create:"Create",
    WhatEnum.receive:"Receive",
    WhatEnum.update:"Update",
    WhatEnum.delete:"Delete",
    WhatEnum.request:"Request",
  };

  return enumString[whatEnum];
}

enum WhereEnum{
  groupwork,
  assignment,
  task,
  reference,
}

String getWhereEnumString(WhereEnum whereEnum){
  Map<WhereEnum,String> enumString = {
    WhereEnum.groupwork:"Groupwork",
    WhereEnum.assignment:"Assignment",
    WhereEnum.task:"Task",
    WhereEnum.reference:"Reference"
  };
  return enumString[whereEnum];
}