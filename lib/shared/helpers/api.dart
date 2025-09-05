class Api {
  /* User */
  static const String signUp = 'User/Register';
  static const String signIn = 'User/SignIn';
  static const String signOut = 'User/LogOut';
  static const String validateEmail = 'User/ValidateEmail';
  static const String validateFormData = 'User/ValidateFormData';
  static const String validateRememberPswEmail =
      'User/ValidateRememberPswEmail';
  static const String sendCodeVerify = 'User/SendCodeVerify';
  static const String sendRememberPswEmail = 'User/SendRememberPasswordEmail';
  static const String cancelAccount = 'User/CancelAccount';
  static const String rememberPassword = 'User/RememberPassword';
  static const String changePassword = 'User/ChangePassword';
  static const String createSupplier = 'User/CreateUserSup';
  static const String createShop = 'User/CreateUserShop';
  static const String searchSuppliers = 'User/GetSupUsersByFilter';
  static const String searchSuppliersByNeed = 'User/GetSupUsersByNeed';
  static const String searchShops = 'User/GetShopUsersByFilter';

  /* Sup/Partner */
  static const String createInviteToShop = 'Sup/Partner/CreateInvite';
  static const String cancelInviteToShop = 'Sup/Partner/CancelInvite';
  static const String confirmInviteFromShop = 'Sup/Partner/ConfirmInvite';
  static const String rejectInviteFromShop = 'Sup/Partner/RejectInvite';
  static const String searchPartnersSup = 'Sup/Partner/GetPartners';
  static const String breakPartnerSup = 'Sup/Partner/BreakPartner';

  /* Sup/Home */
  static const String getValuesHeaderSup = 'Sup/Home/GetValuesHeader';

  /* Sup/Profile */
  static const String getProfileSup = 'Sup/Profile/GetProfile';
  static const String saveProfileSup = 'Sup/Profile/SaveProfile';

  /*Sup/CreditCard */
  static const String getCreditCards = 'Sup/CreditCard/GetCreditCards';
  static const String saveCreditCard = 'Sup/CreditCard/SaveCreditCard';
  static const String deleteCreditCard = 'Sup/CreditCard/DeleteCreditCard';
  static const String setDefaultCreditCard =
      'Sup/CreditCard/SetDefaultCreditCard';

  /* Shop/Partner */
  static const String createInviteToSupplier = 'Shop/Partner/CreateInvite';
  static const String cancelInviteToSupplier = 'Shop/Partner/CancelInvite';
  static const String confirmInviteFromSupplier = 'Shop/Partner/ConfirmInvite';
  static const String rejectInviteFromSupplier = 'Shop/Partner/RejectInvite';
  static const String searchPartnersShop = 'Shop/Partner/GetMyPartners';
  static const String breakPartnerShop = 'Shop/Partner/BreakPartner';

  /* Shop/Home */
  static const String getValuesHeaderShop = 'Shop/Home/GetValuesHeader';

  /*Shop/Profile */
  static const String getProfile = 'Shop/Profile/GetProfile';
  static const String saveProfile = 'Shop/Profile/SaveProfile';

  /*Shop/Employee */
  static const String getEmployees = 'Shop/Employee/GetEmployees';
  static const String saveEmployee = 'Shop/Employee/SaveEmployee';
  static const String deleteEmployee = 'Shop/Employee/DeleteEmployee';

  /*Shop/BankAccount */
  static const String getBankAccount = 'Shop/BankAccount/GetBankAccount';
  static const String saveBankAccount = 'Shop/BankAccount/SaveBankAccount';

  /*Shop/Dispute */
  static const String getDispute = 'Shop/Dispute/GetDispute';
  static const String approveDispute = 'Shop/Dispute/ApproveDispute';
  static const String disapproveDispute = 'Shop/Dispute/DisapproveDispute';

  /* Notification */
  static const String loadNotifications = 'Notification/GetNotifications';
  static const String countNotifications = 'Notification/GetCountNotifications';
  static const String updateNotifications = 'Notification/UpdateNotifications';

  /* Shop/Reference */
  static const String createReference = 'Shop/Reference/Create';
  static const String deleteReference = 'Shop/Reference/Delete';
  static const String loadReferences = 'Shop/Reference/GetAllReferences';
  static const String supByReference = 'Shop/Reference/GetSuppliersByReference';

  /* Pagar-me/GeraToken */

  static const String generateToken = 'tokens';

  /* Sup/Reference */
  static const String loadReferencesSup = 'Sup/Reference/GetAllReferences';
  static const String acceptReferenceSup = 'Sup/Reference/AcceptReference';
  static const String rejectReferenceSup = 'Sup/Reference/RejectReference';
  static const String myReferencesSup =
      'Sup/Reference/GetAcceptedReferencesPage';
  static const String setDoneDeal = 'Sup/Reference/UpdateDoneDeal';

  /*Combo*/
  static const String loadCitiesByUf = 'City/FindByUf';
  static const String loadCitiesSup = 'City/FindAllCitiesSup';
  static const String loadCitiesShop = 'City/FindAllCitiesShop';

  /*Need*/
  static const String loadNeeds = 'Need/GetAllNeeds';
  static const String loadNeedSup = 'Need/GetNeedsBySupplier';
  static const String loadNeedSupProfile = 'Need/GetNeedsBySupplierProfile';

  /*Sup/Dispute */
  static const String getDisputes = 'Sup/Dispute/GetByShop';
  static const String createDispute = 'Sup/Dispute/Create';
  static const String updateDispute = 'Sup/Dispute/Update';
}
