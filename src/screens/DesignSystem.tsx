import { StatusBar, TopBar } from '../components/Chrome'
import { Badge, Card, Chip } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { Input } from '../components/ui/Input'
import { useApp } from '../context/AppContext'
import { Mail } from 'lucide-react'

const colors = [
  { name: 'Primary', varName: '--vh-primary' },
  { name: 'Secondary', varName: '--vh-secondary' },
  { name: 'Accent', varName: '--vh-accent' },
  { name: 'Success', varName: '--vh-success' },
  { name: 'Warning', varName: '--vh-warning' },
  { name: 'Danger', varName: '--vh-danger' },
]

export function DesignSystemScreen() {
  const { t, theme, setTheme, lang, setLang } = useApp()

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('designSystem')} subtitle="8pt grid · Component library" />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <Card className="ds-intro">
            <h2>VehicleHub Design System</h2>
            <p>
              Premium bilingual automotive UI kit for Pakistan — Material + iOS inspired, production spacing,
              light & dark tokens.
            </p>
            <div className="chip-scroll" style={{ marginTop: 12 }}>
              <Chip active={theme === 'light'} onClick={() => setTheme('light')}>{t('light')}</Chip>
              <Chip active={theme === 'dark'} onClick={() => setTheme('dark')}>{t('dark')}</Chip>
              <Chip active={lang === 'en'} onClick={() => setLang('en')}>EN</Chip>
              <Chip active={lang === 'ur'} onClick={() => setLang('ur')}>اردو</Chip>
            </div>
          </Card>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Color palette</h3>
          <div className="swatch-grid">
            {colors.map((c) => (
              <div key={c.name} className="swatch">
                <div className="swatch-color" style={{ background: `var(${c.varName})` }} />
                <span>{c.name}</span>
              </div>
            ))}
          </div>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Typography</h3>
          <Card>
            <p style={{ fontSize: 28, fontWeight: 700, letterSpacing: '-0.03em' }}>Display / Poppins</p>
            <p style={{ fontSize: 20, fontWeight: 600, marginTop: 8 }}>Title medium</p>
            <p style={{ fontSize: 14, color: 'var(--vh-text-secondary)', marginTop: 8 }}>
              Body text for English UI. 8pt baseline grid.
            </p>
            <p className="ur-text" style={{ fontSize: 22, marginTop: 16 }}>
              اردو عنوان — نوتو نستعلیق
            </p>
            <p className="ur-text" style={{ fontSize: 15, color: 'var(--vh-text-secondary)' }}>
              آپ کی گاڑی کا ڈیجیٹل ساتھی
            </p>
          </Card>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Buttons</h3>
          <div className="ds-stack">
            <Button fullWidth>Primary</Button>
            <Button fullWidth variant="secondary">Secondary</Button>
            <Button fullWidth variant="accent">Accent</Button>
            <Button fullWidth variant="outline">Outline</Button>
            <Button fullWidth variant="soft">Soft</Button>
            <Button fullWidth variant="danger">Danger</Button>
            <div className="vh-row" style={{ gap: 8 }}>
              <Button size="sm">Small</Button>
              <Button size="md">Medium</Button>
              <Button size="lg">Large</Button>
            </div>
          </div>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Inputs</h3>
          <Input label="Email" placeholder="name@email.com" leftIcon={<Mail size={18} />} />
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Badges & chips</h3>
          <div className="vh-row" style={{ flexWrap: 'wrap', gap: 8 }}>
            <Badge tone="primary">Primary</Badge>
            <Badge tone="success">Success</Badge>
            <Badge tone="warning">Warning</Badge>
            <Badge tone="danger">Danger</Badge>
            <Badge tone="accent">Accent</Badge>
          </div>
          <div className="chip-scroll" style={{ marginTop: 12 }}>
            <Chip active>Active</Chip>
            <Chip>Default</Chip>
            <Chip>Filter</Chip>
          </div>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Cards</h3>
          <Card>
            <strong>Elevated card</strong>
            <p className="vh-secondary-text" style={{ fontSize: 13, marginTop: 6 }}>
              Soft shadow, 16px radius, 16px padding — interaction container only.
            </p>
          </Card>
        </div>

        <div className="vh-section">
          <h3 className="ds-h">Radius & elevation</h3>
          <div className="radius-row">
            <div style={{ borderRadius: 8 }}>8</div>
            <div style={{ borderRadius: 12 }}>12</div>
            <div style={{ borderRadius: 16 }}>16</div>
            <div style={{ borderRadius: 24 }}>24</div>
          </div>
        </div>
      </div>
    </div>
  )
}
