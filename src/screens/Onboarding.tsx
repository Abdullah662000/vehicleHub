import { useState } from 'react'
import { Button } from '../components/ui/Button'
import { StatusBar } from '../components/Chrome'
import { OnboardingArt } from '../components/Illustrations'
import { useApp } from '../context/AppContext'

const slides = [
  { title: 'onb1Title', desc: 'onb1Desc' },
  { title: 'onb2Title', desc: 'onb2Desc' },
  { title: 'onb3Title', desc: 'onb3Desc' },
  { title: 'onb4Title', desc: 'onb4Desc' },
] as const

export function OnboardingScreen() {
  const { navigate, t, lang } = useApp()
  const [i, setI] = useState(0)
  const slide = slides[i]
  const last = i === slides.length - 1

  return (
    <div className="vh-screen onboarding">
      <StatusBar />
      <div className="onb-top">
        <button type="button" className="skip" onClick={() => navigate('language')}>
          {t('skip')}
        </button>
      </div>
      <OnboardingArt index={i} />
      <div className="onb-body">
        <div className="onb-dots">
          {slides.map((_, idx) => (
            <span key={idx} className={idx === i ? 'active' : ''} />
          ))}
        </div>
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t(slide.title)}</h2>
        <p className={lang === 'ur' ? 'ur-text' : ''}>{t(slide.desc)}</p>
        <Button
          fullWidth
          size="lg"
          onClick={() => (last ? navigate('language') : setI((x) => x + 1))}
        >
          {last ? t('getStarted') : t('next')}
        </Button>
      </div>
    </div>
  )
}

export function LanguageScreen() {
  const { navigate, t, lang, setLang } = useApp()
  return (
    <div className="vh-screen lang-screen">
      <StatusBar />
      <div className="lang-body">
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t('chooseLanguage')}</h2>
        <p className={lang === 'ur' ? 'ur-text' : ''}>{t('chooseLanguageDesc')}</p>
        <button
          type="button"
          className={`lang-card ${lang === 'en' ? 'active' : ''}`}
          onClick={() => setLang('en')}
        >
          <span className="flag">EN</span>
          <div>
            <strong>English</strong>
            <small>Primary language</small>
          </div>
        </button>
        <button
          type="button"
          className={`lang-card ${lang === 'ur' ? 'active' : ''}`}
          onClick={() => setLang('ur')}
        >
          <span className="flag ur">اردو</span>
          <div>
            <strong className="ur-text">اردو</strong>
            <small className="ur-text">ثانوی زبان</small>
          </div>
        </button>
        <Button fullWidth size="lg" onClick={() => navigate('login')}>
          {t('continue')}
        </Button>
      </div>
    </div>
  )
}
