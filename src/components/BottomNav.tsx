import {
  Home,
  Warehouse,
  Wrench,
  Wallet,
  User,
} from 'lucide-react'
import { useApp, type ScreenId } from '../context/AppContext'

const tabs: { id: ScreenId; icon: typeof Home; key: 'home' | 'garage' | 'mechanics' | 'expenses' | 'profile' }[] = [
  { id: 'home', icon: Home, key: 'home' },
  { id: 'garage', icon: Warehouse, key: 'garage' },
  { id: 'mechanics', icon: Wrench, key: 'mechanics' },
  { id: 'expenses', icon: Wallet, key: 'expenses' },
  { id: 'profile', icon: User, key: 'profile' },
]

export function BottomNav() {
  const { screen, navigate, t } = useApp()
  const active = tabs.some((tab) => tab.id === screen)
  if (!active) return null

  return (
    <nav className="vh-bottom-nav" aria-label="Primary">
      {tabs.map((tab) => {
        const Icon = tab.icon
        const isActive = screen === tab.id
        return (
          <button
            key={tab.id}
            type="button"
            className={`vh-nav-item ${isActive ? 'active' : ''}`}
            onClick={() => navigate(tab.id)}
          >
            <span className="vh-nav-icon">
              <Icon size={22} strokeWidth={isActive ? 2.4 : 1.8} />
            </span>
            <span className="vh-nav-label">{t(tab.key)}</span>
          </button>
        )
      })}
    </nav>
  )
}
