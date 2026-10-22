import { Apple, Mail, Phone, Lock, User } from 'lucide-react'
import { useState } from 'react'
import { Button } from '../components/ui/Button'
import { Input } from '../components/ui/Input'
import { StatusBar, TopBar } from '../components/Chrome'
import { useApp } from '../context/AppContext'

export function LoginScreen() {
  const { navigate, t, lang } = useApp()
  return (
    <div className="vh-screen auth">
      <StatusBar />
      <TopBar showBack title={t('login')} />
      <div className="vh-scroll no-nav auth-body">
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t('welcomeBack')}</h2>
        <p className={`auth-sub ${lang === 'ur' ? 'ur-text' : ''}`}>{t('loginSubtitle')}</p>
        <div className="auth-stack">
          <Input label={t('email')} placeholder="ahmed@email.com" leftIcon={<Mail size={18} />} />
          <Input label={t('password')} type="password" placeholder="••••••••" leftIcon={<Lock size={18} />} />
          <button type="button" className="link-right" onClick={() => {}}>
            {t('forgotPassword')}
          </button>
          <Button fullWidth size="lg" onClick={() => navigate('otp')}>
            {t('login')}
          </Button>
        </div>
        <div className="auth-divider"><span>{t('orContinue')}</span></div>
        <div className="auth-social">
          <Button variant="outline" fullWidth icon={<GoogleIcon />}>{t('continueGoogle')}</Button>
          <Button variant="outline" fullWidth icon={<Apple size={18} />}>{t('continueApple')}</Button>
          <Button variant="soft" fullWidth icon={<Phone size={18} />} onClick={() => navigate('otp')}>
            {t('phoneLogin')}
          </Button>
        </div>
        <p className="auth-switch">
          {t('noAccount')}{' '}
          <button type="button" onClick={() => navigate('signup')}>{t('signup')}</button>
        </p>
      </div>
    </div>
  )
}

export function SignupScreen() {
  const { navigate, t, lang } = useApp()
  return (
    <div className="vh-screen auth">
      <StatusBar />
      <TopBar showBack title={t('signup')} />
      <div className="vh-scroll no-nav auth-body">
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t('createAccount')}</h2>
        <p className={`auth-sub ${lang === 'ur' ? 'ur-text' : ''}`}>{t('signupSubtitle')}</p>
        <div className="auth-stack">
          <Input label={t('fullName')} placeholder="Ahmed Khan" leftIcon={<User size={18} />} />
          <Input label={t('phone')} placeholder="03XX XXXXXXX" leftIcon={<Phone size={18} />} />
          <Input label={t('email')} placeholder="ahmed@email.com" leftIcon={<Mail size={18} />} />
          <Input label={t('password')} type="password" placeholder="••••••••" leftIcon={<Lock size={18} />} />
          <Button fullWidth size="lg" onClick={() => navigate('otp')}>{t('signup')}</Button>
        </div>
        <p className="auth-switch">
          {t('hasAccount')}{' '}
          <button type="button" onClick={() => navigate('login')}>{t('login')}</button>
        </p>
      </div>
    </div>
  )
}

export function OtpScreen() {
  const { navigate, t, lang } = useApp()
  const [code, setCode] = useState(['', '', '', '', '', ''])
  return (
    <div className="vh-screen auth">
      <StatusBar />
      <TopBar showBack title={t('otpTitle')} />
      <div className="vh-scroll no-nav auth-body">
        <h2 className={lang === 'ur' ? 'ur-text' : ''}>{t('otpTitle')}</h2>
        <p className={`auth-sub ${lang === 'ur' ? 'ur-text' : ''}`}>
          {t('otpDesc')} <strong>+92 300 1234567</strong>
        </p>
        <div className="otp-row">
          {code.map((d, i) => (
            <input
              key={i}
              className="otp-cell"
              maxLength={1}
              value={d}
              inputMode="numeric"
              onChange={(e) => {
                const next = [...code]
                next[i] = e.target.value.replace(/\D/g, '')
                setCode(next)
              }}
            />
          ))}
        </div>
        <Button fullWidth size="lg" onClick={() => navigate('vehicle-register')}>{t('verify')}</Button>
        <button type="button" className="resend">{t('resendCode')}</button>
      </div>
    </div>
  )
}

function GoogleIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" aria-hidden>
      <path fill="#EA4335" d="M12 10.2v3.9h5.5c-.2 1.3-1.7 3.8-5.5 3.8A6.4 6.4 0 1 1 12 5.6c1.8 0 3 .8 3.7 1.4l2.5-2.4A10 10 0 1 0 12 22c5.4 0 9-3.8 9-9.1 0-.6-.1-1.1-.2-1.7H12z" />
    </svg>
  )
}
