typedef Lang = String;

String tr(String key, Lang lang) {
  return AppStrings.strings[key]?[lang] ?? key;
}

class AppStrings {
  AppStrings._();

  static const Map<String, Map<String, String>> strings = {
    // Brand
    'appName': {'en': 'VehicleHub', 'ur': 'وہیکل ہب'},
    'tagline': {
      'en': "Your Vehicle's Digital Companion",
      'ur': 'آپ کی گاڑی کا ڈیجیٹل ساتھی',
    },

    // Nav
    'home': {'en': 'Home', 'ur': 'ہوم'},
    'garage': {'en': 'Garage', 'ur': 'گیراج'},
    'mechanics': {'en': 'Mechanics', 'ur': 'مکینکس'},
    'expenses': {'en': 'Expenses', 'ur': 'اخراجات'},
    'profile': {'en': 'Profile', 'ur': 'پروفائل'},

    // Common
    'dashboard': {'en': 'Dashboard', 'ur': 'ڈیش بورڈ'},
    'serviceHistory': {'en': 'Service History', 'ur': 'سروس ہسٹری'},
    'maintenance': {'en': 'Maintenance', 'ur': 'دیکھ بھال'},
    'fuelExpenses': {'en': 'Fuel Expenses', 'ur': 'ایندھن کے اخراجات'},
    'emergency': {'en': 'Emergency', 'ur': 'ہنگامی مدد'},
    'vehicleDocuments': {'en': 'Vehicle Documents', 'ur': 'گاڑی کے دستاویزات'},
    'nearbyMechanics': {'en': 'Nearby Mechanics', 'ur': 'قریبی مکینکس'},
    'bookService': {'en': 'Book Service', 'ur': 'سروس بک کریں'},
    'vehicleHealth': {'en': 'Vehicle Health', 'ur': 'گاڑی کی حالت'},
    'upcomingService': {'en': 'Upcoming Service', 'ur': 'آنے والی سروس'},
    'settings': {'en': 'Settings', 'ur': 'ترتیبات'},
    'notifications': {'en': 'Notifications', 'ur': 'اطلاعات'},
    'search': {'en': 'Search', 'ur': 'تلاش'},
    'continue': {'en': 'Continue', 'ur': 'جاری رکھیں'},
    'skip': {'en': 'Skip', 'ur': 'چھوڑیں'},
    'next': {'en': 'Next', 'ur': 'اگلا'},
    'back': {'en': 'Back', 'ur': 'واپس'},
    'save': {'en': 'Save', 'ur': 'محفوظ کریں'},
    'cancel': {'en': 'Cancel', 'ur': 'منسوخ'},
    'confirm': {'en': 'Confirm', 'ur': 'تصدیق'},
    'seeAll': {'en': 'See all', 'ur': 'سب دیکھیں'},
    'verified': {'en': 'Verified', 'ur': 'تصدیق شدہ'},
    'openNow': {'en': 'Open now', 'ur': 'ابھی کھلا'},
    'kmAway': {'en': 'km away', 'ur': 'کلومیٹر دور'},
    'pkr': {'en': 'PKR', 'ur': 'روپے'},

    // Onboarding
    'onb1Title': {
      'en': 'Manage Your Vehicle Digitally',
      'ur': 'اپنی گاڑی کو ڈیجیٹل انداز میں منظم کریں',
    },
    'onb1Desc': {
      'en': 'Keep mileage, health, and documents in one premium garage.',
      'ur': 'مائلیج، صحت اور دستاویزات ایک پریمیم گیراج میں رکھیں۔',
    },
    'onb2Title': {
      'en': 'Track Expenses',
      'ur': 'اپنے اخراجات کا مکمل حساب رکھیں',
    },
    'onb2Desc': {
      'en': 'Fuel, repairs, tolls — clear insights for every rupee.',
      'ur': 'ایندھن، مرمت، ٹول — ہر روپے کی واضح معلومات۔',
    },
    'onb3Title': {
      'en': 'Find Trusted Mechanics',
      'ur': 'قابل اعتماد مکینکس تلاش کریں',
    },
    'onb3Desc': {
      'en': 'Verified workshops near you, rated by real owners.',
      'ur': 'آپ کے قریب تصدیق شدہ ورکشاپس، حقیقی مالکان کی ریٹنگ کے ساتھ۔',
    },
    'onb4Title': {
      'en': 'Never Miss A Service Again',
      'ur': 'اب کبھی بھی سروس مس نہ کریں',
    },
    'onb4Desc': {
      'en': 'Smart reminders for oil, insurance, and registration.',
      'ur': 'آئل، انشورنس اور رجسٹریشن کی اسمارٹ یاددہانیاں۔',
    },
    'getStarted': {'en': 'Get Started', 'ur': 'شروع کریں'},
    'chooseLanguage': {'en': 'Choose Language', 'ur': 'زبان منتخب کریں'},
    'chooseLanguageDesc': {
      'en': 'You can change this anytime in Settings.',
      'ur': 'آپ اسے کبھی بھی ترتیبات میں بدل سکتے ہیں۔',
    },

    // Auth
    'welcomeBack': {'en': 'Welcome back', 'ur': 'خوش آمدید'},
    'loginSubtitle': {
      'en': 'Sign in to manage your vehicles',
      'ur': 'اپنی گاڑیوں کا انتظام کرنے کے لیے سائن ان کریں',
    },
    'createAccount': {'en': 'Create account', 'ur': 'اکاؤنٹ بنائیں'},
    'signupSubtitle': {
      'en': 'Join thousands of Pakistani vehicle owners',
      'ur': 'ہزاروں پاکستانی گاڑی مالکان میں شامل ہوں',
    },
    'email': {'en': 'Email', 'ur': 'ای میل'},
    'password': {'en': 'Password', 'ur': 'پاس ورڈ'},
    'fullName': {'en': 'Full name', 'ur': 'پورا نام'},
    'phone': {'en': 'Phone number', 'ur': 'فون نمبر'},
    'login': {'en': 'Log in', 'ur': 'لاگ ان'},
    'signup': {'en': 'Sign up', 'ur': 'سائن اپ'},
    'forgotPassword': {'en': 'Forgot password?', 'ur': 'پاس ورڈ بھول گئے؟'},
    'orContinue': {'en': 'Or continue with', 'ur': 'یا اس کے ساتھ جاری رکھیں'},
    'continueGoogle': {
      'en': 'Continue with Google',
      'ur': 'گوگل کے ساتھ جاری رکھیں',
    },
    'continueApple': {
      'en': 'Continue with Apple',
      'ur': 'ایپل کے ساتھ جاری رکھیں',
    },
    'phoneLogin': {
      'en': 'Continue with Phone',
      'ur': 'فون کے ساتھ جاری رکھیں',
    },
    'otpTitle': {'en': 'Verify OTP', 'ur': 'او ٹی پی تصدیق'},
    'otpDesc': {
      'en': 'Enter the 6-digit code sent to',
      'ur': 'بھیجا گیا 6 ہندسوں کا کوڈ درج کریں',
    },
    'verify': {'en': 'Verify', 'ur': 'تصدیق کریں'},
    'resendCode': {'en': 'Resend code', 'ur': 'کوڈ دوبارہ بھیجیں'},
    'noAccount': {
      'en': "Don't have an account?",
      'ur': 'اکاؤنٹ نہیں ہے؟',
    },
    'hasAccount': {
      'en': 'Already have an account?',
      'ur': 'پہلے سے اکاؤنٹ ہے؟',
    },

    // Home
    'goodMorning': {'en': 'Good morning', 'ur': 'صبح بخیر'},
    'goodAfternoon': {'en': 'Good afternoon', 'ur': 'دوپہر بخیر'},
    'goodEvening': {'en': 'Good evening', 'ur': 'شام بخیر'},
    'healthScore': {'en': 'Health score', 'ur': 'صحت سکور'},
    'currentMileage': {'en': 'Current mileage', 'ur': 'موجودہ مائلیج'},
    'insuranceReminder': {'en': 'Insurance reminder', 'ur': 'انشورنس یاددہانی'},
    'registrationReminder': {
      'en': 'Registration reminder',
      'ur': 'رجسٹریشن یاددہانی',
    },
    'quickActions': {'en': 'Quick actions', 'ur': 'فوری اقدامات'},
    'bookMechanic': {'en': 'Book Mechanic', 'ur': 'مکینک بک کریں'},
    'findWorkshop': {'en': 'Find Workshop', 'ur': 'ورکشاپ تلاش'},
    'trackExpense': {'en': 'Track Expense', 'ur': 'اخراجات'},
    'documents': {'en': 'Documents', 'ur': 'دستاویزات'},
    'fuel': {'en': 'Fuel', 'ur': 'ایندھن'},
    'recentExpenses': {'en': 'Recent expenses', 'ur': 'حالیہ اخراجات'},
    'recentRepairs': {'en': 'Recent repairs', 'ur': 'حالیہ مرمت'},
    'monthlySpending': {'en': 'Monthly spending', 'ur': 'ماہانہ اخراجات'},
    'todaysTips': {'en': "Today's tip", 'ur': 'آج کی تجویز'},
    'expiresIn': {'en': 'Expires in', 'ur': 'ختم ہونے میں'},
    'days': {'en': 'days', 'ur': 'دن'},

    // Garage
    'myGarage': {'en': 'My Garage', 'ur': 'میرا گیراج'},
    'addVehicle': {'en': 'Add vehicle', 'ur': 'گاڑی شامل کریں'},
    'registrationNo': {'en': 'Registration', 'ur': 'رجسٹریشن'},
    'mileage': {'en': 'Mileage', 'ur': 'مائلیج'},
    'fuelType': {'en': 'Fuel type', 'ur': 'ایندھن کی قسم'},
    'transmission': {'en': 'Transmission', 'ur': 'ٹرانسمیشن'},
    'insuranceStatus': {'en': 'Insurance', 'ur': 'انشورنس'},
    'active': {'en': 'Active', 'ur': 'فعال'},
    'expiring': {'en': 'Expiring soon', 'ur': 'جلد ختم'},
    'expired': {'en': 'Expired', 'ur': 'ختم شدہ'},

    // Vehicle
    'vehicleDetails': {'en': 'Vehicle details', 'ur': 'گاڑی کی تفصیلات'},
    'timeline': {'en': 'Timeline', 'ur': 'ٹائم لائن'},
    'oilChange': {'en': 'Oil change', 'ur': 'آئل چینج'},
    'brakeReplacement': {'en': 'Brake replacement', 'ur': 'بریک تبدیلی'},
    'tyreReplacement': {'en': 'Tyre replacement', 'ur': 'ٹائر تبدیلی'},
    'batteryChange': {'en': 'Battery change', 'ur': 'بیٹری تبدیلی'},
    'acService': {'en': 'AC service', 'ur': 'اے سی سروس'},
    'engineWork': {'en': 'Engine work', 'ur': 'انجن ورک'},
    'warranty': {'en': 'Warranty', 'ur': 'وارنٹی'},
    'notes': {'en': 'Notes', 'ur': 'نوٹس'},
    'uploadInvoice': {'en': 'Upload invoice', 'ur': 'انوائس اپ لوڈ'},

    // Expenses
    'expenseTracker': {'en': 'Expense Tracker', 'ur': 'اخراجات ٹریکر'},
    'addExpense': {'en': 'Add expense', 'ur': 'اخراجات شامل'},
    'thisMonth': {'en': 'This month', 'ur': 'اس مہینے'},
    'thisYear': {'en': 'This year', 'ur': 'اس سال'},
    'costPerKm': {'en': 'Cost / km', 'ur': 'لاگت / کلومیٹر'},
    'repairs': {'en': 'Repairs', 'ur': 'مرمت'},
    'insurance': {'en': 'Insurance', 'ur': 'انشورنس'},
    'registration': {'en': 'Registration', 'ur': 'رجسٹریشن'},
    'accessories': {'en': 'Accessories', 'ur': 'لوازمات'},
    'carWash': {'en': 'Car wash', 'ur': 'کار واش'},
    'parking': {'en': 'Parking', 'ur': 'پارکنگ'},
    'tollTax': {'en': 'Toll tax', 'ur': 'ٹول ٹیکس'},
    'service': {'en': 'Service', 'ur': 'سروس'},
    'tyres': {'en': 'Tyres', 'ur': 'ٹائر'},
    'battery': {'en': 'Battery', 'ur': 'بیٹری'},
    'analytics': {'en': 'Analytics', 'ur': 'تجزیہ'},

    // Fuel
    'fuelTracker': {'en': 'Fuel Tracker', 'ur': 'ایندھن ٹریکر'},
    'fuelEntry': {'en': 'Fuel entry', 'ur': 'ایندھن اندراج'},
    'fuelCost': {'en': 'Fuel cost', 'ur': 'ایندھن لاگت'},
    'fuelQuantity': {'en': 'Quantity (L)', 'ur': 'مقدار (لیٹر)'},
    'fuelEconomy': {'en': 'Fuel economy', 'ur': 'ایندھن معیشت'},
    'addFuel': {'en': 'Add fuel', 'ur': 'ایندھن شامل'},

    // Mechanics
    'findMechanics': {'en': 'Find Mechanics', 'ur': 'مکینکس تلاش'},
    'filters': {'en': 'Filters', 'ur': 'فلٹرز'},
    'distance': {'en': 'Distance', 'ur': 'فاصلہ'},
    'ratings': {'en': 'Ratings', 'ur': 'ریٹنگز'},
    'verifiedOnly': {'en': 'Verified only', 'ur': 'صرف تصدیق شدہ'},
    'bookAppointment': {'en': 'Book appointment', 'ur': 'اپائنٹمنٹ بک'},
    'call': {'en': 'Call', 'ur': 'کال'},
    'whatsapp': {'en': 'WhatsApp', 'ur': 'واٹس ایپ'},
    'emergencyVisit': {'en': 'Emergency visit', 'ur': 'ہنگامی وزٹ'},
    'priceEstimate': {'en': 'Price estimate', 'ur': 'قیمت کا تخمینہ'},
    'workingHours': {'en': 'Working hours', 'ur': 'کام کے اوقات'},
    'reviews': {'en': 'Reviews', 'ur': 'جائزے'},
    'yearsExp': {'en': 'years exp.', 'ur': 'سال تجربہ'},
    'gallery': {'en': 'Gallery', 'ur': 'گیلری'},

    // Booking
    'selectDate': {'en': 'Select date', 'ur': 'تاریخ منتخب'},
    'selectTime': {'en': 'Select time', 'ur': 'وقت منتخب'},
    'problemDesc': {'en': 'Describe the problem', 'ur': 'مسئلہ بیان کریں'},
    'uploadImages': {'en': 'Upload vehicle images', 'ur': 'گاڑی کی تصاویر'},
    'estimatedCost': {'en': 'Estimated cost', 'ur': 'تخمینی لاگت'},
    'confirmBooking': {'en': 'Confirm booking', 'ur': 'بکنگ تصدیق'},
    'paymentLater': {'en': 'Pay at workshop', 'ur': 'ورکشاپ پر ادائیگی'},
    'bookingSuccess': {'en': 'Booking confirmed!', 'ur': 'بکنگ تصدیق ہو گئی!'},

    // Emergency
    'roadside': {'en': 'Roadside Assistance', 'ur': 'سڑک کنارے مدد'},
    'liveLocation': {'en': 'Sharing live location', 'ur': 'لائیو لوکیشن شیئر'},
    'towTruck': {'en': 'Tow truck', 'ur': 'ٹو ٹرک'},
    'jumpStart': {'en': 'Battery jump start', 'ur': 'بیٹری جمپ سٹارٹ'},
    'flatTyre': {'en': 'Flat tyre', 'ur': 'پنکچر'},
    'engineFailure': {'en': 'Engine failure', 'ur': 'انجن فیل'},
    'callDirectly': {'en': 'Call directly', 'ur': 'براہ راست کال'},

    // Documents
    'taxToken': {'en': 'Tax token', 'ur': 'ٹیکس ٹوکن'},
    'drivingLicense': {'en': 'Driving license', 'ur': 'ڈرائیونگ لائسنس'},
    'invoices': {'en': 'Invoices', 'ur': 'انوائسز'},
    'warrantyCards': {'en': 'Warranty cards', 'ur': 'وارنٹی کارڈز'},
    'expiryReminder': {'en': 'Expiry reminder', 'ur': 'ختم ہونے کی یاددہانی'},
    'uploadPdf': {'en': 'Upload PDF', 'ur': 'پی ڈی ایف اپ لوڈ'},

    // Profile / Settings
    'personalInfo': {'en': 'Personal information', 'ur': 'ذاتی معلومات'},
    'myVehicles': {'en': 'My vehicles', 'ur': 'میری گاڑیاں'},
    'savedMechanics': {'en': 'Saved mechanics', 'ur': 'محفوظ مکینکس'},
    'paymentMethods': {'en': 'Payment methods', 'ur': 'ادائیگی کے طریقے'},
    'language': {'en': 'Language', 'ur': 'زبان'},
    'darkMode': {'en': 'Dark mode', 'ur': 'ڈارک موڈ'},
    'help': {'en': 'Help & support', 'ur': 'مدد و تعاون'},
    'privacy': {'en': 'Privacy', 'ur': 'رازداری'},
    'terms': {'en': 'Terms of use', 'ur': 'شرائط استعمال'},
    'logout': {'en': 'Log out', 'ur': 'لاگ آؤٹ'},
    'theme': {'en': 'Theme', 'ur': 'تھیم'},
    'location': {'en': 'Location', 'ur': 'مقام'},
    'light': {'en': 'Light', 'ur': 'لائٹ'},
    'dark': {'en': 'Dark', 'ur': 'ڈارک'},
    'system': {'en': 'System', 'ur': 'سسٹم'},

    // Empty
    'noExpenses': {'en': 'No expenses yet', 'ur': 'ابھی کوئی اخراجات نہیں'},
    'noExpensesDesc': {
      'en': 'Track fuel, repairs, and more in one place.',
      'ur': 'ایندھن، مرمت اور مزید ایک جگہ ٹریک کریں۔',
    },
    'addFirstVehicle': {
      'en': 'Add your first vehicle',
      'ur': 'اپنی پہلی گاڑی شامل کریں',
    },
    'addFirstVehicleDesc': {
      'en': 'Build your digital garage in under a minute.',
      'ur': 'ایک منٹ میں اپنا ڈیجیٹل گیراج بنائیں۔',
    },
    'noServiceHistory': {
      'en': 'No service history',
      'ur': 'کوئی سروس ہسٹری نہیں',
    },
    'noSavedMechanics': {
      'en': 'No saved mechanics',
      'ur': 'کوئی محفوظ مکینک نہیں',
    },

    // Errors
    'networkError': {'en': 'Network error', 'ur': 'نیٹ ورک خرابی'},
    'networkErrorDesc': {
      'en': 'Check your connection and try again.',
      'ur': 'کنکشن چیک کریں اور دوبارہ کوشش کریں۔',
    },
    'locationDisabled': {'en': 'Location disabled', 'ur': 'لوکیشن بند ہے'},
    'locationDisabledDesc': {
      'en': 'Enable location to find nearby mechanics.',
      'ur': 'قریبی مکینکس کے لیے لوکیشن آن کریں۔',
    },
    'noMechanicsNearby': {
      'en': 'No mechanics nearby',
      'ur': 'قریب کوئی مکینک نہیں',
    },
    'otpFailed': {'en': 'OTP verification failed', 'ur': 'او ٹی پی ناکام'},

    // Vehicle registration
    'registerVehicle': {
      'en': 'Register your vehicle',
      'ur': 'اپنی گاڑی رجسٹر کریں',
    },
    'registerVehicleDesc': {
      'en': 'Tell us about your car to personalize reminders.',
      'ur': 'یاددہانیوں کے لیے اپنی گاڑی کی تفصیل بتائیں۔',
    },
    'make': {'en': 'Make', 'ur': 'میک'},
    'model': {'en': 'Model', 'ur': 'ماڈل'},
    'year': {'en': 'Year', 'ur': 'سال'},
    'finishSetup': {'en': 'Finish setup', 'ur': 'سیٹ اپ مکمل'},

    // Design system
    'designSystem': {'en': 'Design System', 'ur': 'ڈیزائن سسٹم'},
    'components': {'en': 'Components', 'ur': 'اجزاء'},
    'prototype': {'en': 'Prototype', 'ur': 'پروٹوٹائپ'},
  };

  static Map<String, String> get en => {
        for (final entry in strings.entries) entry.key: entry.value['en']!,
      };

  static Map<String, String> get ur => {
        for (final entry in strings.entries) entry.key: entry.value['ur']!,
      };
}
