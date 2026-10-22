import { createContext, useContext, useMemo, useState, type ReactNode } from 'react'
import { tr, type Lang } from '../i18n/strings'

export type ThemeMode = 'light' | 'dark'
export type ScreenId =
  | 'splash'
  | 'onboarding'
  | 'language'
  | 'login'
  | 'signup'
  | 'otp'
  | 'vehicle-register'
  | 'home'
  | 'garage'
  | 'vehicle-details'
  | 'service-history'
  | 'mechanics'
  | 'mechanic-profile'
  | 'booking'
  | 'booking-success'
  | 'expenses'
  | 'add-expense'
  | 'fuel'
  | 'emergency'
  | 'documents'
  | 'notifications'
  | 'profile'
  | 'settings'
  | 'search'
  | 'empty-states'
  | 'error-states'
  | 'design-system'

type AppContextValue = {
  lang: Lang
  setLang: (l: Lang) => void
  theme: ThemeMode
  setTheme: (t: ThemeMode) => void
  screen: ScreenId
  navigate: (s: ScreenId) => void
  goBack: () => void
  t: (key: Parameters<typeof tr>[0]) => string
  selectedMechanicId: string | null
  setSelectedMechanicId: (id: string | null) => void
  selectedVehicleId: string | null
  setSelectedVehicleId: (id: string | null) => void
  history: ScreenId[]
}

const AppContext = createContext<AppContextValue | null>(null)

export function AppProvider({ children }: { children: ReactNode }) {
  const [lang, setLang] = useState<Lang>('en')
  const [theme, setTheme] = useState<ThemeMode>('light')
  const [screen, setScreen] = useState<ScreenId>('splash')
  const [history, setHistory] = useState<ScreenId[]>([])
  const [selectedMechanicId, setSelectedMechanicId] = useState<string | null>('m1')
  const [selectedVehicleId, setSelectedVehicleId] = useState<string | null>('v1')

  const value = useMemo<AppContextValue>(
    () => ({
      lang,
      setLang,
      theme,
      setTheme,
      screen,
      history,
      selectedMechanicId,
      setSelectedMechanicId,
      selectedVehicleId,
      setSelectedVehicleId,
      navigate: (s) => {
        setHistory((h) => [...h, screen])
        setScreen(s)
      },
      goBack: () => {
        setHistory((h) => {
          if (h.length === 0) return h
          const prev = h[h.length - 1]
          setScreen(prev)
          return h.slice(0, -1)
        })
      },
      t: (key) => tr(key, lang),
    }),
    [lang, theme, screen, history, selectedMechanicId, selectedVehicleId],
  )

  return <AppContext.Provider value={value}>{children}</AppContext.Provider>
}

export function useApp() {
  const ctx = useContext(AppContext)
  if (!ctx) throw new Error('useApp must be used within AppProvider')
  return ctx
}
