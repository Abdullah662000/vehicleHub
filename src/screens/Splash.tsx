import { useEffect } from 'react'
import { useApp } from '../context/AppContext'
import { VehicleArt } from '../components/Illustrations'

export function SplashScreen() {
  const { navigate, t, lang } = useApp()

  useEffect(() => {
    const id = setTimeout(() => navigate('onboarding'), 1800)
    return () => clearTimeout(id)
  }, [navigate])

  return (
    <div className="vh-screen splash">
      <div className="splash-glow" />
      <div className="splash-content">
        <div className="splash-logo">
          <VehicleArt kind="corolla" size={88} />
        </div>
        <h1 className={lang === 'ur' ? 'ur-text' : ''}>{t('appName')}</h1>
        <p className={lang === 'ur' ? 'ur-text' : ''}>{t('tagline')}</p>
        <div className="splash-loader">
          <span />
        </div>
      </div>
      <p className="splash-foot">Pakistan · Premium Automotive</p>
    </div>
  )
}
