import type { ReactNode } from 'react'
import {
  AlertTriangle,
  FileText,
  Fuel,
  MapPin,
  Shield,
  Wrench,
  Wallet,
  ChevronRight,
  Star,
  Calendar,
} from 'lucide-react'
import { StatusBar } from '../components/Chrome'
import { Badge, Card } from '../components/ui/Card'
import { VehicleArt, MechanicAvatar } from '../components/Illustrations'
import { BottomNav } from '../components/BottomNav'
import { useApp } from '../context/AppContext'
import { expenses, mechanics, monthlySpend, tips, vehicles } from '../data/mock'

function greetingKey(hour: number) {
  if (hour < 12) return 'goodMorning' as const
  if (hour < 17) return 'goodAfternoon' as const
  return 'goodEvening' as const
}

export function HomeScreen() {
  const { t, lang, navigate, setSelectedMechanicId } = useApp()
  const vehicle = vehicles[0]
  const tip = tips[0]
  const maxSpend = Math.max(...monthlySpend.map((m) => m.value))

  return (
    <div className="vh-screen">
      <StatusBar />
      <div className="vh-scroll">
        <div className="home-header">
          <div>
            <p className="home-greet">{t(greetingKey(new Date().getHours()))}</p>
            <h2 className={lang === 'ur' ? 'ur-text' : ''}>Ahmed Khan</h2>
          </div>
          <button type="button" className="avatar-btn" onClick={() => navigate('profile')}>
            AK
          </button>
        </div>

        <div className="vh-section">
          <Card className="vehicle-hero" padding={false} onClick={() => navigate('vehicle-details')}>
            <div className="vehicle-hero-inner">
              <div>
                <Badge tone="success">{t('vehicleHealth')} · {vehicle.health}%</Badge>
                <h3>
                  {vehicle.make} {vehicle.model}
                </h3>
                <p className="vh-muted">{vehicle.reg} · {vehicle.year}</p>
                <div className="hero-stats">
                  <div>
                    <small>{t('currentMileage')}</small>
                    <strong>{vehicle.mileage.toLocaleString()} km</strong>
                  </div>
                  <div>
                    <small>{t('healthScore')}</small>
                    <strong>{vehicle.health}/100</strong>
                  </div>
                </div>
              </div>
              <VehicleArt kind={vehicle.photo} size={110} />
            </div>
            <div className="health-bar">
              <span style={{ width: `${vehicle.health}%` }} />
            </div>
          </Card>
        </div>

        <div className="vh-section">
          <div className="reminder-row">
            <Card className="reminder" onClick={() => navigate('documents')}>
              <Calendar size={18} color="var(--vh-accent)" />
              <div>
                <strong>{t('upcomingService')}</strong>
                <small>{t('oilChange')} · 8 {t('days')}</small>
              </div>
            </Card>
            <Card className="reminder" onClick={() => navigate('documents')}>
              <Shield size={18} color="var(--vh-warning)" />
              <div>
                <strong>{t('insuranceReminder')}</strong>
                <small>{t('expiresIn')} 18 {t('days')}</small>
              </div>
            </Card>
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3>{t('quickActions')}</h3>
          </div>
          <div className="vh-grid-4">
            <Quick icon={<Wrench size={20} />} label={t('bookMechanic')} onClick={() => navigate('mechanics')} tone="primary" />
            <Quick icon={<MapPin size={20} />} label={t('findWorkshop')} onClick={() => navigate('mechanics')} tone="secondary" />
            <Quick icon={<Wallet size={20} />} label={t('trackExpense')} onClick={() => navigate('add-expense')} tone="accent" />
            <Quick icon={<AlertTriangle size={20} />} label={t('emergency')} onClick={() => navigate('emergency')} tone="danger" />
          </div>
          <div className="vh-grid-4" style={{ marginTop: 10 }}>
            <Quick icon={<FileText size={20} />} label={t('documents')} onClick={() => navigate('documents')} tone="neutral" />
            <Quick icon={<Fuel size={20} />} label={t('fuel')} onClick={() => navigate('fuel')} tone="neutral" />
            <Quick icon={<Star size={20} />} label={t('serviceHistory')} onClick={() => navigate('service-history')} tone="neutral" />
            <Quick icon={<Shield size={20} />} label={t('insurance')} onClick={() => navigate('documents')} tone="neutral" />
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3>{t('nearbyMechanics')}</h3>
            <button type="button" className="see-all" onClick={() => navigate('mechanics')}>{t('seeAll')}</button>
          </div>
          <div className="h-scroll">
            {mechanics.slice(0, 3).map((m) => (
              <Card
                key={m.id}
                className="mech-mini"
                onClick={() => {
                  setSelectedMechanicId(m.id)
                  navigate('mechanic-profile')
                }}
              >
                <MechanicAvatar seed={m.photo} size={44} />
                <div>
                  <strong>{m.workshop}</strong>
                  <small>
                    ★ {m.rating} · {m.distance} {t('kmAway')}
                  </small>
                </div>
                {m.verified && <Badge tone="success">{t('verified')}</Badge>}
              </Card>
            ))}
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3>{t('monthlySpending')}</h3>
            <button type="button" className="see-all" onClick={() => navigate('expenses')}>{t('seeAll')}</button>
          </div>
          <Card>
            <div className="bar-chart">
              {monthlySpend.map((m) => (
                <div key={m.label} className="bar-col">
                  <div className="bar" style={{ height: `${(m.value / maxSpend) * 100}%` }} />
                  <span>{m.label}</span>
                </div>
              ))}
            </div>
            <div className="spend-total">
              <span>{t('thisMonth')}</span>
              <strong>PKR {monthlySpend[monthlySpend.length - 1].value.toLocaleString()}</strong>
            </div>
          </Card>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3>{t('recentExpenses')}</h3>
          </div>
          {expenses.slice(0, 3).map((e) => (
            <Card key={e.id} className="expense-row" onClick={() => navigate('expenses')}>
              <div className="expense-ico">{e.category[0]}</div>
              <div className="expense-meta">
                <strong>{e.title}</strong>
                <small>{e.date}</small>
              </div>
              <div className="expense-amt">
                <strong>-{e.amount.toLocaleString()}</strong>
                <ChevronRight size={16} color="var(--vh-text-muted)" />
              </div>
            </Card>
          ))}
        </div>

        <div className="vh-section">
          <Card className="tip-card">
            <Badge tone="accent">{t('todaysTips')}</Badge>
            <p className={lang === 'ur' ? 'ur-text' : ''}>{lang === 'ur' ? tip.ur : tip.en}</p>
          </Card>
        </div>
      </div>
      <BottomNav />
    </div>
  )
}

function Quick({
  icon,
  label,
  onClick,
  tone,
}: {
  icon: ReactNode
  label: string
  onClick: () => void
  tone: string
}) {
  return (
    <button type="button" className={`quick-action tone-${tone}`} onClick={onClick}>
      <span className="quick-ico">{icon}</span>
      <span>{label}</span>
    </button>
  )
}
