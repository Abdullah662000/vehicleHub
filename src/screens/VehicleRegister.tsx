import { Button } from '../components/ui/Button'
import { Input } from '../components/ui/Input'
import { StatusBar, TopBar } from '../components/Chrome'
import { VehicleArt } from '../components/Illustrations'
import { Chip } from '../components/ui/Card'
import { useApp } from '../context/AppContext'
import { useState } from 'react'

const makes = ['Toyota', 'Honda', 'Suzuki', 'Kia', 'Hyundai', 'MG']
const models: Record<string, string[]> = {
  Toyota: ['Corolla', 'Yaris', 'Hilux', 'Fortuner'],
  Honda: ['Civic', 'City', 'BR-V', 'HR-V'],
  Suzuki: ['Alto', 'Cultus', 'Swift', 'Wagon R'],
  Kia: ['Sportage', 'Sorento', 'Picanto', 'Stonic'],
  Hyundai: ['Tucson', 'Elantra', 'Sonata', 'Santa Fe'],
  MG: ['HS', 'ZS', '5', 'GT'],
}

export function VehicleRegisterScreen() {
  const { navigate, t, lang } = useApp()
  const [make, setMake] = useState('Toyota')
  const [model, setModel] = useState('Corolla')

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('registerVehicle')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section" style={{ textAlign: 'center', paddingTop: 8 }}>
          <VehicleArt kind={make === 'Honda' ? 'civic' : make === 'Kia' ? 'sportage' : 'corolla'} size={160} />
          <h2 style={{ marginTop: 8, fontSize: 20 }} className={lang === 'ur' ? 'ur-text' : ''}>
            {t('registerVehicle')}
          </h2>
          <p className={`vh-secondary-text ${lang === 'ur' ? 'ur-text' : ''}`} style={{ fontSize: 13, marginTop: 6 }}>
            {t('registerVehicleDesc')}
          </p>
        </div>
        <div className="vh-section">
          <p className="vh-label" style={{ marginBottom: 10 }}>{t('make')}</p>
          <div className="chip-scroll">
            {makes.map((m) => (
              <Chip key={m} active={make === m} onClick={() => { setMake(m); setModel(models[m][0]) }}>
                {m}
              </Chip>
            ))}
          </div>
        </div>
        <div className="vh-section">
          <p className="vh-label" style={{ marginBottom: 10 }}>{t('model')}</p>
          <div className="chip-scroll">
            {models[make].map((m) => (
              <Chip key={m} active={model === m} onClick={() => setModel(m)}>{m}</Chip>
            ))}
          </div>
        </div>
        <div className="vh-section auth-stack">
          <Input label={t('year')} placeholder="2021" />
          <Input label={t('registrationNo')} placeholder="LES-2041" />
          <Input label={t('mileage')} placeholder="48250" />
          <Button fullWidth size="lg" onClick={() => navigate('home')}>{t('finishSetup')}</Button>
        </div>
      </div>
    </div>
  )
}
