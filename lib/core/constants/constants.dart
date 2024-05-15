class AppConstants {
  static const String paymobAuthenticationRequest =
      "https://accept.paymob.com/api/auth/tokens";
  static const String paymobOrderRegistrationAPI =
      "https://accept.paymob.com/api/ecommerce/orders";
  static const String paymobPaymentKeyRequest =
      "https://accept.paymob.com/api/acceptance/payment_keys";
  static String paymobIframeLink(String key) =>
      "https://accept.paymob.com/api/acceptance/iframes/816095?payment_token=$key";

  static const String storageUrl =
      'https://puobkhhvvespdletdxdp.supabase.co/storage/v1/object/public/';
  static const cardPaymentMethodIntegrationId = '4437214';
  static const mobilePaymentMethodIntegrationId = '4573606';
  static const paymobApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RVek1UQTBMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuSFVmTVo0V1dndzZFY2hzTVFycGlMSlhZRU5rSnk3SkhLdXBBcDRLT0pkMk54b3NaZFQ5X3JxUWNRM1pBUWxpMk9LMG8zXzcxU1NNUE80dWx4SW0wZXc=';
  static const mapboxKey =
      "pk.eyJ1IjoicmFuYXltb2hhbWVkIiwiYSI6ImNsdnU0emZ5ZzE0azgya255ajBkMGVxZWkifQ.ofnZh_HQfe31u--xKaeFDg";
}
