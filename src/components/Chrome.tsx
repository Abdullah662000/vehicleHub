import { Bell, ChevronLeft, Search } from 'lucide-react'
import type { ReactNode } from 'react'
import { useApp } from '../context/AppContext'

export function StatusBar({ light }: { light?: boolean }) {
  return (
    <div className={`vh-status-bar ${light ? 'light' : ''}`}>
      <span>9:41</span>
      <div className="vh-status-icons">
        <span className="sig" />
        <span className="wifi" />
        <span className="batt" />
      </div>
    </div>
  )
}

export function TopBar({
  title,
  subtitle,
  showBack,
  right,
  transparent,
  light,
}: {
  title?: string
  subtitle?: string
  showBack?: boolean
  right?: ReactNode
  transparent?: boolean
  light?: boolean
}) {
  const { goBack, navigate } = useApp()
  return (
    <header className={`vh-topbar ${transparent ? 'transparent' : ''} ${light ? 'light' : ''}`}>
      <div className="vh-topbar-row">
        {showBack ? (
          <button type="button" className="vh-icon-btn" onClick={goBack} aria-label="Back">
            <ChevronLeft size={22} />
          </button>
        ) : (
          <div className="vh-icon-btn spacer" />
        )}
        <div className="vh-topbar-titles">
          {title && <h1>{title}</h1>}
          {subtitle && <p>{subtitle}</p>}
        </div>
        <div className="vh-topbar-right">
          {right ?? (
            <>
              <button type="button" className="vh-icon-btn" onClick={() => navigate('search')} aria-label="Search">
                <Search size={18} />
              </button>
              <button type="button" className="vh-icon-btn" onClick={() => navigate('notifications')} aria-label="Notifications">
                <Bell size={18} />
              </button>
            </>
          )}
        </div>
      </div>
    </header>
  )
}

export function EmptyState({
  icon,
  title,
  description,
  action,
}: {
  icon: ReactNode
  title: string
  description: string
  action?: ReactNode
}) {
  return (
    <div className="vh-empty">
      <div className="vh-empty-icon">{icon}</div>
      <h3>{title}</h3>
      <p>{description}</p>
      {action}
    </div>
  )
}
