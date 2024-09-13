String formatPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.replaceAll(' ', '').replaceAll('-', '');

  if (phoneNumber.startsWith('+920')) {
    phoneNumber = '+92${phoneNumber.substring(4)}';
  }

  // Format the number
  return phoneNumber;
}
