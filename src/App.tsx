import type { ReactNode } from 'react'
import { AnimatePresence, motion } from 'framer-motion'
import { AppProvider, useApp, type ScreenId } from './context/AppContext'
import { SplashScreen } from './screens/Splash'
import { LanguageScreen, OnboardingScreen } from './screens/Onboarding'
import { LoginScreen, OtpScreen, SignupScreen } from './screens/Auth'
import { VehicleRegisterScreen } from './screens/VehicleRegister'
import { HomeScreen } from './screens/Home'
import { GarageScreen } from './screens/Garage'
import { ServiceHistoryScreen, VehicleDetailsScreen } from './screens/Vehicle'
import {
  BookingScreen,
  BookingSuccessScreen,
  MechanicProfileScreen,
  MechanicsScreen,
} from './screens/Mechanics'
import { AddExpenseScreen, ExpensesScreen, FuelScreen } from './screens/Expenses'
import { EmergencyScreen } from './screens/Emergency'
import {
  DocumentsScreen,
  EmptyStatesScreen,
  ErrorStatesScreen,
  NotificationsScreen,
  SearchScreen,
} from './screens/Misc'
import { ProfileScreen, SettingsScreen } from './screens/Profile'
import { DesignSystemScreen } from './screens/DesignSystem'
import { VehicleArt } from './components/Illustrations'

const flows: { group: string; items: { id: ScreenId; label: string }[] }[] = [
  {
    group: 'Journey',
    items: [
      { id: 'splash', label: 'Splash' },
      { id: 'onboarding', label: 'Onboarding' },
      { id: 'language', label: 'Language' },
      { id: 'login', label: 'Login' },
      { id: 'signup', label: 'Signup' },
      { id: 'otp', label: 'OTP' },
      { id: 'vehicle-register', label: 'Vehicle Registration' },
    ],
  },
  {
    group: 'Core tabs',
    items: [
      { id: 'home', label: 'Home Dashboard' },
      { id: 'garage', label: 'Garage' },
      { id: 'mechanics', label: 'Mechanics' },
      { id: 'expenses', label: 'Expenses' },
      { id: 'profile', label: 'Profile' },
    ],
  },
  {
    group: 'Detail flows',
    items: [
      { id: 'vehicle-details', label: 'Vehicle Details' },
      { id: 'service-history', label: 'Service History' },
      { id: 'mechanic-profile', label: 'Mechanic Profile' },
      { id: 'booking', label: 'Book Appointment' },
      { id: 'booking-success', label: 'Booking Success' },
      { id: 'add-expense', label: 'Add Expense' },
      { id: 'fuel', label: 'Fuel Tracker' },
      { id: 'emergency', label: 'Roadside SOS' },
      { id: 'documents', label: 'Documents' },
      { id: 'notifications', label: 'Notifications' },
      { id: 'search', label: 'Global Search' },
      { id: 'settings', label: 'Settings' },
    ],
  },
  {
    group: 'System',
    items: [
      { id: 'design-system', label: 'Design System' },
      { id: 'empty-states', label: 'Empty States' },
      { id: 'error-states', label: 'Error States' },
    ],
  },
]

function ScreenRouter() {
  const { screen } = useApp()
  const map: Record<ScreenId, ReactNode> = {
    splash: <SplashScreen />,
    onboarding: <OnboardingScreen />,
    language: <LanguageScreen />,
    login: <LoginScreen />,
    signup: <SignupScreen />,
    otp: <OtpScreen />,
    'vehicle-register': <VehicleRegisterScreen />,
    home: <HomeScreen />,
    garage: <GarageScreen />,
    'vehicle-details': <VehicleDetailsScreen />,
    'service-history': <ServiceHistoryScreen />,
    mechanics: <MechanicsScreen />,
    'mechanic-profile': <MechanicProfileScreen />,
    booking: <BookingScreen />,
    'booking-success': <BookingSuccessScreen />,
    expenses: <ExpensesScreen />,
    'add-expense': <AddExpenseScreen />,
    fuel: <FuelScreen />,
    emergency: <EmergencyScreen />,
    documents: <DocumentsScreen />,
    notifications: <NotificationsScreen />,
    profile: <ProfileScreen />,
    settings: <SettingsScreen />,
    search: <SearchScreen />,
    'empty-states': <EmptyStatesScreen />,
    'error-states': <ErrorStatesScreen />,
    'design-system': <DesignSystemScreen />,
  }

  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={screen}
        initial={{ opacity: 0, y: 8 }}
        animate={{ opacity: 1, y: 0 }}
        exit={{ opacity: 0, y: -8 }}
        transition={{ duration: 0.22 }}
        style={{ height: '100%' }}
      >
        {map[screen]}
      </motion.div>
    </AnimatePresence>
  )
}

function Studio() {
  const { screen, navigate, theme, setTheme, lang, setLang } = useApp()

  return (
    <div className="studio" data-theme={theme} dir={lang === 'ur' ? 'rtl' : 'ltr'}>
      <aside className="studio-panel">
        <div className="studio-brand">
          <div className="studio-brand-mark">VH</div>
          <div>
            <h1>VehicleHub Pakistan</h1>
            <p>Design prototype · Handoff ready</p>
          </div>
        </div>
        {flows.map((g) => (
          <div key={g.group}>
            <div className="studio-section-label">{g.group}</div>
            {g.items.map((item) => (
              <button
                key={item.id}
                type="button"
                className={`flow-btn ${screen === item.id ? 'active' : ''}`}
                onClick={() => navigate(item.id)}
              >
                {item.label}
              </button>
            ))}
          </div>
        ))}
      </aside>

      <main className="studio-center">
        <div className="studio-toolbar">
          <button type="button" className={`tool-chip ${lang === 'en' ? 'active' : ''}`} onClick={() => setLang('en')}>
            English
          </button>
          <button type="button" className={`tool-chip ${lang === 'ur' ? 'active' : ''}`} onClick={() => setLang('ur')}>
            اردو
          </button>
          <button type="button" className={`tool-chip ${theme === 'light' ? 'active' : ''}`} onClick={() => setTheme('light')}>
            Light
          </button>
          <button type="button" className={`tool-chip ${theme === 'dark' ? 'active' : ''}`} onClick={() => setTheme('dark')}>
            Dark
          </button>
        </div>

        <div className="phone-frame" data-theme={theme} dir={lang === 'ur' ? 'rtl' : 'ltr'}>
          <div className="phone-notch" />
          <div className="phone-screen" data-theme={theme} dir={lang === 'ur' ? 'rtl' : 'ltr'}>
            <ScreenRouter />
          </div>
        </div>
      </main>

      <aside className="studio-panel studio-right">
        <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 12 }}>
          <VehicleArt kind="corolla" size={100} />
        </div>
        <h3>Product spec</h3>
        <p>
          Premium bilingual automotive super-app for Pakistani vehicle owners — garage, expenses,
          verified mechanics, and roadside assistance.
        </p>
        <ul className="spec-list">
          <li>
            <strong>Primary</strong>
            Royal Blue #1B4DFF
          </li>
          <li>
            <strong>Secondary</strong>
            Emerald #10B981
          </li>
          <li>
            <strong>Accent</strong>
            Orange #FF7A1A
          </li>
          <li>
            <strong>Type EN</strong>
            Poppins
          </li>
          <li>
            <strong>Type UR</strong>
            Noto Nastaliq Urdu
          </li>
          <li>
            <strong>Grid</strong>
            8pt · 390×844 mobile
          </li>
          <li>
            <strong>Nav</strong>
            Home · Garage · Mechanics · Expenses · Profile
          </li>
        </ul>
      </aside>
    </div>
  )
}

export default function App() {
  return (
    <AppProvider>
      <Studio />
    </AppProvider>
  )
}
