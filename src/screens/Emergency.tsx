import type { ReactNode } from 'react'
import {
  AlertTriangle,
  BatteryCharging,
  Car,
  Disc,
  MapPin,
  Phone,
  ShieldAlert,
} from 'lucide-react'
import { StatusBar, TopBar } from '../components/Chrome'
import { MechanicAvatar } from '../components/Illustrations'
import { Badge, Card } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { useApp } from '../context/AppContext'
import { mechanics } from '../data/mock'

export function EmergencyScreen() {
  const { t, navigate, setSelectedMechanicId, lang } = useApp()

  return (
    <div className="vh-screen emergency-screen">
      <StatusBar light />
      <TopBar showBack title={t('roadside')} light transparent />
      <div className="vh-scroll no-nav">
        <div className="sos-wrap">
          <button type="button" className="sos-btn">
            <AlertTriangle size={36} />
            <span>SOS</span>
          </button>
          <p className={lang === 'ur' ? 'ur-text' : ''}>{t('liveLocation')}</p>
          <div className="live-pill">
            <MapPin size={14} />
            Gulberg III, Lahore
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-grid-2">
            <EmergencyTile icon={<Car size={22} />} label={t('towTruck')} />
            <EmergencyTile icon={<BatteryCharging size={22} />} label={t('jumpStart')} />
            <EmergencyTile icon={<Disc size={22} />} label={t('flatTyre')} />
            <EmergencyTile icon={<ShieldAlert size={22} />} label={t('engineFailure')} />
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3 style={{ color: '#fff' }}>{t('nearbyMechanics')}</h3>
          </div>
          {mechanics
            .filter((m) => m.open)
            .slice(0, 2)
            .map((m) => (
              <Card
                key={m.id}
                className="mech-card"
                onClick={() => {
                  setSelectedMechanicId(m.id)
                  navigate('mechanic-profile')
                }}
              >
                <div className="mech-card-top">
                  <MechanicAvatar seed={m.photo} size={48} />
                  <div style={{ flex: 1 }}>
                    <strong>{m.workshop}</strong>
                    <p className="vh-muted" style={{ fontSize: 12 }}>
                      {m.distance} {t('kmAway')} · ★ {m.rating}
                    </p>
                  </div>
                  <Badge tone="danger">{t('emergency')}</Badge>
                </div>
                <Button fullWidth variant="accent" icon={<Phone size={16} />} style={{ marginTop: 12 }}>
                  {t('callDirectly')}
                </Button>
              </Card>
            ))}
        </div>
      </div>
    </div>
  )
}

function EmergencyTile({ icon, label }: { icon: ReactNode; label: string }) {
  return (
    <button type="button" className="emergency-tile">
      {icon}
      <span>{label}</span>
    </button>
  )
}
