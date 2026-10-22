import {
  ChevronRight,
  CreditCard,
  Heart,
  HelpCircle,
  Languages,
  LogOut,
  Moon,
  Shield,
  FileText,
  User,
  Car,
  Palette,
} from 'lucide-react'
import { BottomNav } from '../components/BottomNav'
import { StatusBar, TopBar } from '../components/Chrome'
import { Card } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { useApp } from '../context/AppContext'

export function ProfileScreen() {
  const { t, navigate, lang } = useApp()
  const rows = [
    { icon: User, label: t('personalInfo'), go: 'settings' as const },
    { icon: Car, label: t('myVehicles'), go: 'garage' as const },
    { icon: Heart, label: t('savedMechanics'), go: 'mechanics' as const },
    { icon: CreditCard, label: t('paymentMethods'), go: 'settings' as const },
    { icon: Languages, label: t('language'), go: 'settings' as const },
    { icon: Moon, label: t('darkMode'), go: 'settings' as const },
    { icon: HelpCircle, label: t('help'), go: 'settings' as const },
    { icon: Shield, label: t('privacy'), go: 'settings' as const },
    { icon: FileText, label: t('terms'), go: 'settings' as const },
    { icon: Palette, label: t('designSystem'), go: 'design-system' as const },
  ]

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar title={t('profile')} />
      <div className="vh-scroll">
        <div className="vh-section">
          <Card className="profile-head">
            <div className="avatar-lg">AK</div>
            <div>
              <h2 className={lang === 'ur' ? 'ur-text' : ''}>Ahmed Khan</h2>
              <p className="vh-muted">+92 300 1234567</p>
              <p className="vh-muted">ahmed@email.com</p>
            </div>
          </Card>
        </div>
        <div className="vh-section">
          <Card padding={false}>
            {rows.map((r) => {
              const Icon = r.icon
              return (
                <button key={r.label} type="button" className="settings-row" onClick={() => navigate(r.go)}>
                  <span className="settings-ico"><Icon size={18} /></span>
                  <span className="settings-label">{r.label}</span>
                  <ChevronRight size={16} color="var(--vh-text-muted)" />
                </button>
              )
            })}
          </Card>
          <Button fullWidth variant="danger" icon={<LogOut size={16} />} style={{ marginTop: 16 }} onClick={() => navigate('login')}>
            {t('logout')}
          </Button>
          <div className="dev-links">
            <button type="button" onClick={() => navigate('empty-states')}>Empty states</button>
            <button type="button" onClick={() => navigate('error-states')}>Error states</button>
          </div>
        </div>
      </div>
      <BottomNav />
    </div>
  )
}

export function SettingsScreen() {
  const { t, lang, setLang, theme, setTheme, navigate } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('settings')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <h3 style={{ fontSize: 14, marginBottom: 10 }}>{t('language')}</h3>
          <Card padding={false}>
            <button type="button" className={`settings-row ${lang === 'en' ? 'on' : ''}`} onClick={() => setLang('en')}>
              <span className="settings-label">English</span>
              {lang === 'en' && <span className="check">●</span>}
            </button>
            <button type="button" className={`settings-row ${lang === 'ur' ? 'on' : ''}`} onClick={() => setLang('ur')}>
              <span className="settings-label ur-text">اردو</span>
              {lang === 'ur' && <span className="check">●</span>}
            </button>
          </Card>
        </div>
        <div className="vh-section">
          <h3 style={{ fontSize: 14, marginBottom: 10 }}>{t('theme')}</h3>
          <Card padding={false}>
            <button type="button" className={`settings-row ${theme === 'light' ? 'on' : ''}`} onClick={() => setTheme('light')}>
              <span className="settings-label">{t('light')}</span>
              {theme === 'light' && <span className="check">●</span>}
            </button>
            <button type="button" className={`settings-row ${theme === 'dark' ? 'on' : ''}`} onClick={() => setTheme('dark')}>
              <span className="settings-label">{t('dark')}</span>
              {theme === 'dark' && <span className="check">●</span>}
            </button>
          </Card>
        </div>
        <div className="vh-section">
          <Card padding={false}>
            <button type="button" className="settings-row" onClick={() => navigate('notifications')}>
              <span className="settings-label">{t('notifications')}</span>
              <ChevronRight size={16} color="var(--vh-text-muted)" />
            </button>
            <button type="button" className="settings-row">
              <span className="settings-label">{t('location')}</span>
              <ChevronRight size={16} color="var(--vh-text-muted)" />
            </button>
            <button type="button" className="settings-row">
              <span className="settings-label">{t('privacy')}</span>
              <ChevronRight size={16} color="var(--vh-text-muted)" />
            </button>
          </Card>
        </div>
      </div>
    </div>
  )
}
