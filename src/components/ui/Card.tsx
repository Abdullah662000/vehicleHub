import type { CSSProperties, ReactNode } from 'react'

export function Card({
  children,
  className = '',
  onClick,
  padding = true,
  style,
}: {
  children: ReactNode
  className?: string
  onClick?: () => void
  padding?: boolean
  style?: CSSProperties
}) {
  return (
    <div className={`vh-card ${padding ? 'pad' : ''} ${onClick ? 'clickable' : ''} ${className}`} onClick={onClick} style={style}>
      {children}
    </div>
  )
}

export function Badge({
  children,
  tone = 'primary',
}: {
  children: ReactNode
  tone?: 'primary' | 'success' | 'warning' | 'danger' | 'neutral' | 'accent'
}) {
  return <span className={`vh-badge vh-badge-${tone}`}>{children}</span>
}

export function Chip({
  children,
  active,
  onClick,
  icon,
}: {
  children: ReactNode
  active?: boolean
  onClick?: () => void
  icon?: ReactNode
}) {
  return (
    <button type="button" className={`vh-chip ${active ? 'active' : ''}`} onClick={onClick}>
      {icon}
      {children}
    </button>
  )
}
