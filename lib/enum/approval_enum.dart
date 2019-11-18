enum Approval{
  approved,
  deny,
  tbd,
}

String getApprovalEnumString(Approval approval){
  Map<Approval,String> approvalString = {
    Approval.approved: "Approved",
    Approval.deny: "Deny",
    Approval.tbd:"TBD"
  };

  return approvalString[approval];
}