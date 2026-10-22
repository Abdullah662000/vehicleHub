import { Plus } from 'lucide-react'
import { BottomNav } from '../components/BottomNav'
import { StatusBar, TopBar } from '../components/Chrome'
import { Badge, Card, Chip } from '../components/ui/Card'
import { Button } from '../components/ui/Button'
import { Input } from '../components/ui/Input'
import { useApp } from '../context/AppContext'
import { categorySpend, expenses, monthlySpend } from '../data/mock'
import { useState } from 'react'

export function ExpensesScreen() {
  const { t, navigate } = useApp()
  const total = expenses.reduce((s, e) => s + e.amount, 0)
  const max = Math.max(...monthlySpend.map((m) => m.value))

  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar
        title={t('expenseTracker')}
        right={
          <button type="button" className="vh-icon-btn" onClick={() => navigate('add-expense')} aria-label="Add">
            <Plus size={20} />
          </button>
        }
      />
      <div className="vh-scroll">
        <div className="vh-section">
          <Card className="spend-hero">
            <small>{t('thisMonth')}</small>
            <h2>PKR {monthlySpend[6].value.toLocaleString()}</h2>
            <div className="spend-kpis">
              <div>
                <small>{t('thisYear')}</small>
                <strong>PKR 171,900</strong>
              </div>
              <div>
                <small>{t('costPerKm')}</small>
                <strong>PKR 12.4</strong>
              </div>
            </div>
          </Card>
        </div>

        <div className="vh-section">
          <div className="vh-section-title"><h3>{t('analytics')}</h3></div>
          <Card>
            <div className="pie-wrap">
              <div
                className="pie"
                style={{
                  background: `conic-gradient(${categorySpend
                    .map((c, i, arr) => {
                      const start = arr.slice(0, i).reduce((s, x) => s + x.value, 0)
                      return `${c.color} ${start}% ${start + c.value}%`
                    })
                    .join(', ')})`,
                }}
              />
              <div className="pie-legend">
                {categorySpend.map((c) => (
                  <div key={c.label} className="legend-row">
                    <i style={{ background: c.color }} />
                    <span>{c.label}</span>
                    <strong>{c.value}%</strong>
                  </div>
                ))}
              </div>
            </div>
            <div className="bar-chart" style={{ marginTop: 16, height: 100 }}>
              {monthlySpend.map((m) => (
                <div key={m.label} className="bar-col">
                  <div className="bar" style={{ height: `${(m.value / max) * 100}%` }} />
                  <span>{m.label}</span>
                </div>
              ))}
            </div>
          </Card>
        </div>

        <div className="vh-section">
          <div className="chip-scroll">
            {['All', t('fuel'), t('repairs'), t('service'), t('tollTax')].map((c, i) => (
              <Chip key={c} active={i === 0}>{c}</Chip>
            ))}
          </div>
        </div>

        <div className="vh-section">
          {expenses.map((e) => (
            <Card key={e.id} className="expense-row">
              <div className="expense-ico">{e.category[0]}</div>
              <div className="expense-meta">
                <strong>{e.title}</strong>
                <small>
                  {e.category} · {e.date}
                </small>
              </div>
              <strong className="expense-amt">-{e.amount.toLocaleString()}</strong>
            </Card>
          ))}
          <p className="vh-muted" style={{ textAlign: 'center', fontSize: 12, marginTop: 8 }}>
            Recent total PKR {total.toLocaleString()}
          </p>
        </div>
      </div>
      <BottomNav />
    </div>
  )
}

export function AddExpenseScreen() {
  const { t, navigate } = useApp()
  const cats = [t('fuel'), t('repairs'), t('service'), t('insurance'), t('carWash'), t('tollTax'), t('parking'), t('tyres')]
  const [cat, setCat] = useState(cats[0])
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('addExpense')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <div className="chip-scroll">
            {cats.map((c) => (
              <Chip key={c} active={cat === c} onClick={() => setCat(c)}>{c}</Chip>
            ))}
          </div>
        </div>
        <div className="vh-section auth-stack">
          <Input label="Title" placeholder="PSO Petrol — DHA" />
          <Input label={`${t('pkr')} Amount`} placeholder="8960" inputMode="numeric" />
          <Input label={t('mileage')} placeholder="48250" />
          <Button fullWidth size="lg" onClick={() => navigate('expenses')}>{t('save')}</Button>
        </div>
      </div>
    </div>
  )
}

export function FuelScreen() {
  const { t, navigate } = useApp()
  return (
    <div className="vh-screen">
      <StatusBar />
      <TopBar showBack title={t('fuelTracker')} />
      <div className="vh-scroll no-nav">
        <div className="vh-section">
          <Card className="spend-hero fuel-hero">
            <small>{t('fuelEconomy')}</small>
            <h2>11.8 km/L</h2>
            <div className="spend-kpis">
              <div>
                <small>{t('thisMonth')}</small>
                <strong>PKR 12,480</strong>
              </div>
              <div>
                <small>Avg fill</small>
                <strong>32 L</strong>
              </div>
            </div>
          </Card>
        </div>
        <div className="vh-section auth-stack">
          <h3 style={{ fontSize: 15 }}>{t('fuelEntry')}</h3>
          <Input label={t('fuelCost')} placeholder="8960" />
          <Input label={t('fuelQuantity')} placeholder="32" />
          <Input label={t('mileage')} placeholder="48250" />
          <Button fullWidth size="lg" onClick={() => navigate('expenses')}>{t('addFuel')}</Button>
        </div>
        <div className="vh-section">
          <h3 style={{ fontSize: 15, marginBottom: 10 }}>Fuel history</h3>
          {[1, 2, 3].map((i) => (
            <Card key={i} className="expense-row">
              <div className="expense-ico">F</div>
              <div className="expense-meta">
                <strong>PSO / Shell · 30–34L</strong>
                <small>{i} week{i > 1 ? 's' : ''} ago</small>
              </div>
              <Badge tone="primary">11.{8 - i} km/L</Badge>
            </Card>
          ))}
        </div>
      </div>
    </div>
  )
}
