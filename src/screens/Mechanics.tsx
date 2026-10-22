import { useState } from 'react'
import {
  BadgeCheck,
  Clock,
  Filter,
  MapPin,
  MessageCircle,
  Phone,
  Search,
  Star,
} from 'lucide-react'
import { BottomNav } from '../components/BottomNav'
import { StatusBar, TopBar } from '../components/Chrome'
import { MechanicAvatar } from '../components/Illustrations'
import { Badge, Card, Chip } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { Input, TextArea } from '../components/ui/Input'
import { useApp } from '../context/AppContext'
import { mechanics } from '../data/mock'

const categories = [
  'Honda Specialist',
  'Toyota Specialist',
  'Suzuki Specialist',
  'German Cars',
  'AC Expert',
  'Engine',
  'Tyres',
  'Battery',
  'Emergency',
]

export function MechanicsScreen() {
  const { t, navigate, setSelectedMechanicId } = useApp()
  const [filter, setFilter] = useState('All')

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar title={t('findMechanics')} />
      <div className="vh-scroll">
        <div className="vh-section">
          <div className="search-row">
            <div className="search-box">
              <Search size={18} />
              <input placeholder={`${t('search')}…`} />
            </div>
            <button type="button" className="filter-btn" aria-label={t('filters')}>
              <Filter size={18} />
            </button>
          </div>
          <div className="chip-scroll" style={{ marginTop: 12 }}>
            <Chip active={filter === 'All'} onClick={() => setFilter('All')}>All</Chip>
            <Chip active={filter === 'verified'} onClick={() => setFilter('verified')} icon={<BadgeCheck size={14} />}>
              {t('verifiedOnly')}
            </Chip>
            <Chip active={filter === 'open'} onClick={() => setFilter('open')}>{t('openNow')}</Chip>
            <Chip active={filter === 'emergency'} onClick={() => setFilter('emergency')}>{t('emergency')}</Chip>
          </div>
          <div className="chip-scroll" style={{ marginTop: 8 }}>
            {categories.map((c) => (
              <Chip key={c} active={filter === c} onClick={() => setFilter(c)}>{c}</Chip>
            ))}
          </div>
        </div>

        <div className="vh-section">
          {mechanics
            .filter((m) => {
              if (filter === 'verified') return m.verified
              if (filter === 'open') return m.open
              if (filter === 'emergency') return m.services.includes('Emergency') || m.specialty === 'Emergency'
              if (categories.includes(filter)) return m.specialty.includes(filter.split(' ')[0]) || m.services.some((s) => filter.includes(s))
              return true
            })
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
                  <MechanicAvatar seed={m.photo} size={56} />
                  <div style={{ flex: 1 }}>
                    <div className="vh-row" style={{ gap: 6 }}>
                      <strong>{m.workshop}</strong>
                      {m.verified && <BadgeCheck size={16} color="var(--vh-secondary)" />}
                    </div>
                    <p className="vh-muted" style={{ fontSize: 12 }}>{m.specialty} · {m.name}</p>
                    <div className="mech-stats">
                      <span><Star size={12} fill="var(--vh-warning)" color="var(--vh-warning)" /> {m.rating}</span>
                      <span>{m.distance} {t('kmAway')}</span>
                      <span>{m.experience} {t('yearsExp')}</span>
                    </div>
                  </div>
                  <Badge tone={m.open ? 'success' : 'neutral'}>{m.open ? t('openNow') : 'Closed'}</Badge>
                </div>
                <div className="chip-scroll" style={{ marginTop: 10 }}>
                  {m.brands.map((b) => (
                    <Badge key={b} tone="primary">{b}</Badge>
                  ))}
                </div>
              </Card>
            ))}
        </div>
      </div>
      <BottomNav />
    </div>
  )
}

export function MechanicProfileScreen() {
  const { t, selectedMechanicId, navigate } = useApp()
  const m = mechanics.find((x) => x.id === selectedMechanicId) ?? mechanics[0]

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={m.workshop} />
      <div className="vh-scroll no-nav">
        <div className="vh-section profile-hero">
          <MechanicAvatar seed={m.photo} size={72} />
          <div>
            <div className="vh-row" style={{ gap: 6 }}>
              <h2 style={{ fontSize: 20 }}>{m.workshop}</h2>
              {m.verified && <Badge tone="success">{t('verified')}</Badge>}
            </div>
            <p className="vh-muted">{m.name} · {m.specialty}</p>
            <div className="mech-stats" style={{ marginTop: 8 }}>
              <span><Star size={13} fill="var(--vh-warning)" color="var(--vh-warning)" /> {m.rating} ({m.reviews})</span>
              <span>{m.experience} {t('yearsExp')}</span>
            </div>
          </div>
        </div>

        <div className="vh-section vh-grid-2">
          <Button variant="primary" icon={<Phone size={16} />}>{t('call')}</Button>
          <Button variant="secondary" icon={<MessageCircle size={16} />}>{t('whatsapp')}</Button>
        </div>

        <div className="vh-section">
          <Card>
            <div className="info-line"><MapPin size={16} /><span>{m.location}</span></div>
            <div className="info-line"><Clock size={16} /><span>{t('workingHours')}: {m.hours}</span></div>
            <div className="info-line"><span className="est-label">{t('priceEstimate')}</span><strong>{m.estimate}</strong></div>
          </Card>
        </div>

        <div className="vh-section">
          <h3 style={{ fontSize: 15, marginBottom: 10 }}>{t('gallery')}</h3>
          <div className="gallery-grid">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className={`gallery-tile t${i}`} />
            ))}
          </div>
        </div>

        <div className="vh-section">
          <h3 style={{ fontSize: 15, marginBottom: 10 }}>{t('reviews')}</h3>
          <Card>
            <div className="vh-row" style={{ justifyContent: 'space-between' }}>
              <strong>Hassan R.</strong>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                <Star size={12} fill="var(--vh-warning)" color="var(--vh-warning)" /> 5.0
              </span>
            </div>
            <p className="vh-secondary-text" style={{ fontSize: 13, marginTop: 8, lineHeight: 1.5 }}>
              Excellent Toyota specialist. Honest pricing and finished my Corolla oil + filter in under an hour.
            </p>
          </Card>
        </div>

        <div className="vh-section" style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          <Button fullWidth size="lg" onClick={() => navigate('booking')}>{t('bookAppointment')}</Button>
          <Button fullWidth variant="accent" onClick={() => navigate('emergency')}>{t('emergencyVisit')}</Button>
        </div>
      </div>
    </div>
  )
}

export function BookingScreen() {
  const { t, navigate, selectedMechanicId } = useApp()
  const m = mechanics.find((x) => x.id === selectedMechanicId) ?? mechanics[0]
  const times = ['10:00', '11:30', '14:00', '16:30', '18:00']
  const [time, setTime] = useState('14:00')

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('bookAppointment')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <Card className="vh-row" style={{ gap: 12 }}>
            <MechanicAvatar seed={m.photo} size={48} />
            <div>
              <strong>{m.workshop}</strong>
              <p className="vh-muted" style={{ fontSize: 12 }}>{m.location}</p>
            </div>
          </Card>
        </div>
        <div className="vh-section">
          <h3 style={{ fontSize: 14, marginBottom: 10 }}>{t('selectDate')}</h3>
          <div className="date-row">
            {['Mon 28', 'Tue 29', 'Wed 30', 'Thu 31', 'Fri 1'].map((d, i) => (
              <button key={d} type="button" className={`date-pill ${i === 2 ? 'active' : ''}`}>{d}</button>
            ))}
          </div>
        </div>
        <div className="vh-section">
          <h3 style={{ fontSize: 14, marginBottom: 10 }}>{t('selectTime')}</h3>
          <div className="chip-scroll">
            {times.map((tm) => (
              <Chip key={tm} active={time === tm} onClick={() => setTime(tm)}>{tm}</Chip>
            ))}
          </div>
        </div>
        <div className="vh-section auth-stack">
          <TextArea label={t('problemDesc')} placeholder="AC not cooling properly on highway…" />
          <Button variant="soft" fullWidth>{t('uploadImages')}</Button>
          <Card>
            <div className="vh-row" style={{ justifyContent: 'space-between' }}>
              <span className="vh-secondary-text">{t('estimatedCost')}</span>
              <strong>{m.estimate}</strong>
            </div>
            <p className="vh-muted" style={{ fontSize: 12, marginTop: 8 }}>{t('paymentLater')}</p>
          </Card>
          <Button fullWidth size="lg" onClick={() => navigate('booking-success')}>{t('confirmBooking')}</Button>
        </div>
      </div>
    </div>
  )
}

export function BookingSuccessScreen() {
  const { t, navigate, lang } = useApp()
  return (
    <div className="vh-screen success-screen">
      <StatusBar />
      <div className="success-body">
        <div className="success-burst">✓</div>
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t('bookingSuccess')}</h2>
        <p className="vh-secondary-text">Wed 30 · 14:00 · Ali Auto Care</p>
        <Button fullWidth size="lg" onClick={() => navigate('home')}>{t('home')}</Button>
        <Button fullWidth variant="ghost" onClick={() => navigate('mechanics')}>{t('mechanics')}</Button>
      </div>
    </div>
  )
}
