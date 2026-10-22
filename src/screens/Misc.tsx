import {
  FileText,
  IdCard,
  Receipt,
  Shield,
  Upload,
  WalletCards,
} from 'lucide-react'
import { StatusBar, TopBar, EmptyState } from '../components/Chrome'
import { Badge, Card } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { useApp } from '../context/AppContext'
import { Car, WifiOff, MapPinOff, KeyRound, Wrench } from 'lucide-react'

const docs = [
  { key: 'insurance', icon: Shield, status: 'warning', days: 18 },
  { key: 'registration', icon: FileText, status: 'success', days: 120 },
  { key: 'taxToken', icon: Receipt, status: 'success', days: 90 },
  { key: 'drivingLicense', icon: IdCard, status: 'warning', days: 40 },
  { key: 'invoices', icon: WalletCards, status: 'neutral', days: null },
  { key: 'warrantyCards', icon: FileText, status: 'neutral', days: null },
] as const

export function DocumentsScreen() {
  const { t } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('vehicleDocuments')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          {docs.map((d) => {
            const Icon = d.icon
            return (
              <Card key={d.key} className="doc-card">
                <div className="doc-ico">
                  <Icon size={20} />
                </div>
                <div style={{ flex: 1 }}>
                  <strong>{t(d.key)}</strong>
                  {d.days != null ? (
                    <p className="vh-muted" style={{ fontSize: 12 }}>
                      {t('expiresIn')} {d.days} {t('days')}
                    </p>
                  ) : (
                    <p className="vh-muted" style={{ fontSize: 12 }}>
                      {t('uploadPdf')} / photos
                    </p>
                  )}
                </div>
                <Badge
                  tone={
                    d.status === 'success'
                      ? 'success'
                      : d.status === 'warning'
                        ? 'warning'
                        : 'neutral'
                  }
                >
                  {d.days != null ? t('expiryReminder') : 'Upload'}
                </Badge>
              </Card>
            )
          })}
          <Button fullWidth variant="soft" icon={<Upload size={16} />} style={{ marginTop: 8 }}>
            {t('uploadPdf')}
          </Button>
        </div>
      </div>
    </div>
  )
}

export function NotificationsScreen() {
  const { t } = useApp()
  const items = [
    { title: t('oilChange'), desc: 'Due in 8 days · Toyota Corolla', tone: 'accent' as const },
    { title: t('insuranceReminder'), desc: 'Expires in 18 days', tone: 'warning' as const },
    { title: t('registrationReminder'), desc: 'All good · 120 days left', tone: 'success' as const },
    { title: 'Booking update', desc: 'Ali Auto Care confirmed Wed 14:00', tone: 'primary' as const },
    { title: 'Special offer', desc: '20% off AC service nearby', tone: 'accent' as const },
  ]
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('notifications')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          {items.map((n) => (
            <Card key={n.title} className="notif-card">
              <Badge tone={n.tone}>{t('notifications')}</Badge>
              <strong style={{ display: 'block', marginTop: 8 }}>{n.title}</strong>
              <p className="vh-secondary-text" style={{ fontSize: 13, marginTop: 4 }}>{n.desc}</p>
            </Card>
          ))}
        </div>
      </div>
    </div>
  )
}

export function SearchScreen() {
  const { t, navigate } = useApp()
  const results = [
    { label: 'Toyota Corolla Gli', type: t('myVehicles'), go: 'vehicle-details' as const },
    { label: 'Ali Auto Care', type: t('mechanics'), go: 'mechanic-profile' as const },
    { label: 'Oil change history', type: t('serviceHistory'), go: 'service-history' as const },
    { label: 'Fuel expenses July', type: t('expenses'), go: 'expenses' as const },
  ]
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('search')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <div className="search-box lg">
            <input autoFocus placeholder={`${t('search')} vehicles, mechanics, docs…`} />
          </div>
        </div>
        <div className="vh-section">
          {results.map((r) => (
            <Card key={r.label} className="doc-card" onClick={() => navigate(r.go)}>
              <div style={{ flex: 1 }}>
                <strong>{r.label}</strong>
                <p className="vh-muted" style={{ fontSize: 12 }}>{r.type}</p>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </div>
  )
}

export function EmptyStatesScreen() {
  const { t, navigate } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title="Empty states" />
      <div className="vh-scroll no-nav">
        <EmptyState
          icon={<WalletCards size={28} />}
          title={t('noExpenses')}
          description={t('noExpensesDesc')}
          action={<Button onClick={() => navigate('add-expense')}>{t('addExpense')}</Button>}
        />
        <EmptyState
          icon={<Car size={28} />}
          title={t('addFirstVehicle')}
          description={t('addFirstVehicleDesc')}
          action={<Button variant="secondary" onClick={() => navigate('vehicle-register')}>{t('addVehicle')}</Button>}
        />
        <EmptyState
          icon={<Wrench size={28} />}
          title={t('noServiceHistory')}
          description={t('noSavedMechanics')}
        />
      </div>
    </div>
  )
}

export function ErrorStatesScreen() {
  const { t } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title="Error states" />
      <div className="vh-scroll no-nav">
        <EmptyState icon={<WifiOff size={28} />} title={t('networkError')} description={t('networkErrorDesc')} action={<Button>{t('continue')}</Button>} />
        <EmptyState icon={<MapPinOff size={28} />} title={t('locationDisabled')} description={t('locationDisabledDesc')} />
        <EmptyState icon={<Wrench size={28} />} title={t('noMechanicsNearby')} description={t('locationDisabledDesc')} />
        <EmptyState icon={<KeyRound size={28} />} title={t('otpFailed')} description={t('resendCode')} />
      </div>
    </div>
  )
}
