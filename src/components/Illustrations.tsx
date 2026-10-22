/** Flat automotive illustrations — Pakistani market vehicles */
export function VehicleArt({
  kind = 'corolla',
  size = 120,
}: {
  kind?: string
  size?: number
}) {
  const palette: Record<string, { body: string; accent: string; glass: string }> = {
    corolla: { body: '#1B4DFF', accent: '#0E35C9', glass: '#BFDBFE' },
    civic: { body: '#0F172A', accent: '#334155', glass: '#E2E8F0' },
    alto: { body: '#10B981', accent: '#059669', glass: '#A7F3D0' },
    hilux: { body: '#78350F', accent: '#92400E', glass: '#FDE68A' },
    city: { body: '#64748B', accent: '#475569', glass: '#E2E8F0' },
    sportage: { body: '#FF7A1A', accent: '#EA580C', glass: '#FED7AA' },
    tucson: { body: '#0EA5E9', accent: '#0284C7', glass: '#BAE6FD' },
    mg: { body: '#DC2626', accent: '#B91C1C', glass: '#FECACA' },
  }
  const c = palette[kind] ?? palette.corolla

  return (
    <svg width={size} height={size * 0.62} viewBox="0 0 200 124" fill="none" aria-hidden>
      <ellipse cx="100" cy="112" rx="70" ry="6" fill="currentColor" opacity="0.08" />
      <path
        d="M28 78c8-22 28-34 52-36h40c24 2 44 14 52 36l4 14H24l4-14z"
        fill={c.body}
      />
      <path d="M52 48c10-10 22-14 38-14h20c16 0 28 4 38 14l-8 18H60l-8-18z" fill={c.glass} />
      <path d="M70 48h20v18H66l4-18zm40 0h20l4 18H110V48z" fill={c.accent} opacity="0.25" />
      <rect x="24" y="88" width="152" height="10" rx="3" fill={c.accent} />
      <circle cx="54" cy="98" r="14" fill="#0F172A" />
      <circle cx="54" cy="98" r="7" fill="#94A3B8" />
      <circle cx="146" cy="98" r="14" fill="#0F172A" />
      <circle cx="146" cy="98" r="7" fill="#94A3B8" />
      <rect x="36" y="80" width="12" height="5" rx="2" fill="#FBBF24" />
      <rect x="152" y="80" width="12" height="5" rx="2" fill="#EF4444" />
      <path d="M95 42h10v4H95z" fill={c.accent} />
    </svg>
  )
}

export function MechanicAvatar({ seed, size = 48 }: { seed: string; size?: number }) {
  const hues: Record<string, string> = {
    m1: '#1B4DFF',
    m2: '#10B981',
    m3: '#FF7A1A',
    m4: '#8B5CF6',
  }
  const bg = hues[seed] ?? '#1B4DFF'
  return (
    <div
      style={{
        width: size,
        height: size,
        borderRadius: size * 0.28,
        background: `linear-gradient(145deg, ${bg}, ${bg}99)`,
        display: 'grid',
        placeItems: 'center',
        color: '#fff',
        fontWeight: 700,
        fontSize: size * 0.34,
        flexShrink: 0,
      }}
    >
      {seed.replace('m', 'U').slice(0, 1)}
    </div>
  )
}

export function OnboardingArt({ index }: { index: number }) {
  const kinds = ['corolla', 'sportage', 'civic', 'hilux'] as const
  return (
    <div className="onb-art">
      <div className="onb-orb" />
      <VehicleArt kind={kinds[index]} size={220} />
    </div>
  )
}
