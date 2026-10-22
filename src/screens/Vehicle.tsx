import { Camera, FileUp, Star } from 'lucide-react'
import { StatusBar, TopBar } from '../components/Chrome'
import { VehicleArt } from '../components/Illustrations'
import { Badge, Card, Chip } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { useApp } from '../context/AppContext'
import { serviceTimeline, vehicles } from '../data/mock'

export function VehicleDetailsScreen() {
  const { t, selectedVehicleId, navigate } = useApp()
  const v = vehicles.find((x) => x.id === selectedVehicleId) ?? vehicles[0]

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('vehicleDetails')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section" style={{ textAlign: 'center' }}>
          <VehicleArt kind={v.photo} size={180} />
          <h2 style={{ fontSize: 22, marginTop: 4 }}>
            {v.make} {v.model}
          </h2>
          <p className="vh-muted">
            {v.year} · {v.reg}
          </p>
          <div className="detail-stats">
            <div>
              <small>{t('mileage')}</small>
              <strong>{v.mileage.toLocaleString()}</strong>
            </div>
            <div>
              <small>{t('healthScore')}</small>
              <strong>{v.health}</strong>
            </div>
            <div>
              <small>{t('fuelType')}</small>
              <strong>{v.fuelType}</strong>
            </div>
          </div>
        </div>

        <div className="vh-section">
          <div className="chip-scroll">
            <Chip active>{t('timeline')}</Chip>
            <Chip onClick={() => navigate('documents')}>{t('documents')}</Chip>
            <Chip onClick={() => navigate('service-history')}>{t('serviceHistory')}</Chip>
            <Chip>{t('notes')}</Chip>
          </div>
        </div>

        <div className="vh-section">
          <div className="vh-section-title">
            <h3>{t('timeline')}</h3>
            <button type="button" className="see-all" onClick={() => navigate('service-history')}>
              {t('seeAll')}
            </button>
          </div>
          <div className="timeline">
            {serviceTimeline.map((s, i) => (
              <div key={s.id} className="timeline-item">
                <div className="tl-rail">
                  <span className="tl-dot" />
                  {i < serviceTimeline.length - 1 && <span className="tl-line" />}
                </div>
                <Card className="tl-card">
                  <div className="vh-row" style={{ justifyContent: 'space-between' }}>
                    <strong>{s.title}</strong>
                    <Badge tone="neutral">{s.date}</Badge>
                  </div>
                  <p className="vh-secondary-text" style={{ fontSize: 12, marginTop: 4 }}>
                    {s.workshop} · {s.mechanic}
                  </p>
                  <div className="vh-row" style={{ marginTop: 10, justifyContent: 'space-between' }}>
                    <span style={{ fontWeight: 600 }}>PKR {s.cost.toLocaleString()}</span>
                    <span className="vh-muted" style={{ display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                      <Star size={12} fill="var(--vh-warning)" color="var(--vh-warning)" /> {s.rating}.0
                    </span>
                  </div>
                </Card>
              </div>
            ))}
          </div>
        </div>

        <div className="vh-section vh-grid-2">
          <Button variant="soft" icon={<Camera size={16} />}>{t('uploadImages')}</Button>
          <Button variant="outline" icon={<FileUp size={16} />}>{t('uploadInvoice')}</Button>
        </div>
      </div>
    </div>
  )
}

export function ServiceHistoryScreen() {
  const { t } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('serviceHistory')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <div className="timeline">
            {serviceTimeline.map((s, i) => (
              <div key={s.id} className="timeline-item">
                <div className="tl-rail">
                  <span className="tl-dot" />
                  {i < serviceTimeline.length - 1 && <span className="tl-line" />}
                </div>
                <Card className="tl-card">
                  <strong>{s.title}</strong>
                  <p className="vh-secondary-text" style={{ fontSize: 12, margin: '6px 0' }}>
                    {s.date} · {s.workshop}
                  </p>
                  <div className="parts">
                    {s.parts.map((p) => (
                      <Badge key={p} tone="neutral">{p}</Badge>
                    ))}
                  </div>
                  <div className="vh-row" style={{ marginTop: 12, justifyContent: 'space-between' }}>
                    <div>
                      <small className="vh-muted">{t('warranty')}</small>
                      <div style={{ fontWeight: 600, fontSize: 13 }}>{s.warranty}</div>
                    </div>
                    <div style={{ textAlign: 'right' }}>
                      <small className="vh-muted">Cost</small>
                      <div style={{ fontWeight: 700 }}>PKR {s.cost.toLocaleString()}</div>
                    </div>
                  </div>
                </Card>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
