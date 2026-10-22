import type { ButtonHTMLAttributes, ReactNode } from 'react'
import './ui.css'

type Variant = 'primary' | 'secondary' | 'accent' | 'ghost' | 'danger' | 'outline' | 'soft'
type Size = 'sm' | 'md' | 'lg'

type Props = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: Variant
  size?: Size
  fullWidth?: boolean
  icon?: ReactNode
  iconRight?: ReactNode
  loading?: boolean
}

export function Button({
  variant = 'primary',
  size = 'md',
  fullWidth,
  icon,
  iconRight,
  loading,
  children,
  className = '',
  disabled,
  ...rest
}: Props) {
  return (
    <button
      className={`vh-btn vh-btn-${variant} vh-btn-${size} ${fullWidth ? 'full' : ''} ${className}`}
      disabled={disabled || loading}
      {...rest}
    >
      {loading ? <span className="vh-spinner" /> : icon}
      <span>{children}</span>
      {iconRight}
    </button>
  )
}
