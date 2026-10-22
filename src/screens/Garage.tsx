import { Plus, ShieldCheck } from 'lucide-react'
import { BottomNav } from '../components/BottomNav'
import { StatusBar, TopBar } from '../components/Chrome'
import { VehicleArt } from '../components/Illustrations'
import { Badge, Card } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { useApp } from '../context/AppContext'
import { vehicles } from '../data/mock'

export function GarageScreen() {
  const { t, navigate, setSelectedVehicleId } = useApp()

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar title={t('myGarage')} subtitle={`${vehicles.length} vehicles`} />
      <div className="vh-scroll">
        <div className="vh-section">
          {vehicles.map((v) => (
            <Card
              key={v.id}
              className="garage-card"
              onClick={() => {
                setSelectedVehicleId(v.id)
                navigate('vehicle-details')
              }}
            >
              <div className="garage-top">
                <VehicleArt kind={v.photo} size={96} />
                <div className="garage-info">
                  <div className="vh-row" style={{ justifyContent: 'space-between' }}>
                    <h3>
                      {v.make} {v.model}
                    </h3>
                    <Badge tone={v.insurance === 'active' ? 'success' : v.insurance === 'expiring' ? 'warning' : 'danger'}>
                      {t(v.insurance === 'active' ? 'active' : v.insurance === 'expiring' ? 'expiring' : 'expired')}
                    </Badge>
                  </div>
                  <p className="vh-muted">
                    {v.year} · {v.reg}
                  </p>
                  <div className="garage-meta">
                    <span>{v.mileage.toLocaleString()} km</span>
                    <span>{v.fuelType}</span>
                    <span>{v.transmission}</span>
                  </div>
                  <div className="mini-health">
                    <ShieldCheck size={14} />
                    <span>
                      {t('vehicleHealth')} {v.health}%
                    </span>
                    <div className="mini-bar">
                      <i style={{ width: `${v.health}%` }} />
                    </div>
                  </div>
                </div>
              </div>
            </Card>
          ))}
          <Button
            variant="soft"
            fullWidth
            size="lg"
            icon={<Plus size={18} />}
            onClick={() => navigate('vehicle-register')}
          >
            {t('addVehicle')}
          </Button>
        </div>
      </div>
      <BottomNav />
    </div>
  )
}
