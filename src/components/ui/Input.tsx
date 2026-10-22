import type { InputHTMLAttributes, ReactNode, TextareaHTMLAttributes } from 'react'

type Props = InputHTMLAttributes<HTMLInputElement> & {
  label?: string
  hint?: string
  error?: string
  leftIcon?: ReactNode
  rightIcon?: ReactNode
}

export function Input({ label, hint, error, leftIcon, rightIcon, className = '', ...rest }: Props) {
  return (
    <label className={`vh-field ${className}`}>
      {label && <span className="vh-label">{label}</span>}
      <div className={`vh-input-wrap ${error ? 'error' : ''}`}>
        {leftIcon && <span className="vh-input-icon">{leftIcon}</span>}
        <input className="vh-input" {...rest} />
        {rightIcon && <span className="vh-input-icon right">{rightIcon}</span>}
      </div>
      {(error || hint) && <span className={`vh-hint ${error ? 'err' : ''}`}>{error || hint}</span>}
    </label>
  )
}

type AreaProps = TextareaHTMLAttributes<HTMLTextAreaElement> & {
  label?: string
}

export function TextArea({ label, className = '', ...rest }: AreaProps) {
  return (
    <label className={`vh-field ${className}`}>
      {label && <span className="vh-label">{label}</span>}
      <textarea className="vh-textarea" rows={4} {...rest} />
    </label>
  )
}
