export type Vehicle = {
  id: string
  photo: string
  make: string
  model: string
  year: number
  reg: string
  mileage: number
  fuelType: string
  transmission: string
  insurance: 'active' | 'expiring' | 'expired'
  health: number
  color: string
}

export type Mechanic = {
  id: string
  name: string
  workshop: string
  photo: string
  verified: boolean
  rating: number
  reviews: number
  experience: number
  distance: number
  brands: string[]
  services: string[]
  open: boolean
  hours: string
  location: string
  specialty: string
  estimate: string
}

export type Expense = {
  id: string
  category: string
  title: string
  amount: number
  date: string
  icon: string
}

export const vehicles: Vehicle[] = [
  {
    id: 'v1',
    photo: 'corolla',
    make: 'Toyota',
    model: 'Corolla Gli',
    year: 2021,
    reg: 'LES-2041',
    mileage: 48250,
    fuelType: 'Petrol',
    transmission: 'Automatic',
    insurance: 'expiring',
    health: 86,
    color: '#1B4DFF',
  },
  {
    id: 'v2',
    photo: 'civic',
    make: 'Honda',
    model: 'Civic Oriel',
    year: 2019,
    reg: 'ICT-8892',
    mileage: 71400,
    fuelType: 'Petrol',
    transmission: 'Automatic',
    insurance: 'active',
    health: 78,
    color: '#10B981',
  },
  {
    id: 'v3',
    photo: 'sportage',
    make: 'Kia',
    model: 'Sportage AWD',
    year: 2023,
    reg: 'RWP-5510',
    mileage: 12680,
    fuelType: 'Petrol',
    transmission: 'Automatic',
    insurance: 'active',
    health: 94,
    color: '#FF7A1A',
  },
]

export const mechanics: Mechanic[] = [
  {
    id: 'm1',
    name: 'Usman Ali',
    workshop: 'Ali Auto Care',
    photo: 'm1',
    verified: true,
    rating: 4.9,
    reviews: 312,
    experience: 14,
    distance: 1.2,
    brands: ['Toyota', 'Honda', 'Suzuki'],
    services: ['Engine', 'AC', 'Oil Change', 'Suspension'],
    open: true,
    hours: '9:00 AM – 9:00 PM',
    location: 'Gulberg III, Lahore',
    specialty: 'Toyota Specialist',
    estimate: 'PKR 2,500 – 8,000',
  },
  {
    id: 'm2',
    name: 'Bilal Khan',
    workshop: 'Khan Motors',
    photo: 'm2',
    verified: true,
    rating: 4.7,
    reviews: 198,
    experience: 9,
    distance: 2.8,
    brands: ['Honda', 'MG', 'Hyundai'],
    services: ['Denting', 'Painting', 'Battery', 'Tyres'],
    open: true,
    hours: '10:00 AM – 8:00 PM',
    location: 'F-10 Markaz, Islamabad',
    specialty: 'Honda Specialist',
    estimate: 'PKR 3,000 – 12,000',
  },
  {
    id: 'm3',
    name: 'Asif Raza',
    workshop: 'German Car Lab',
    photo: 'm3',
    verified: true,
    rating: 4.8,
    reviews: 87,
    experience: 11,
    distance: 4.1,
    brands: ['BMW', 'Mercedes', 'Audi'],
    services: ['Diagnostics', 'Transmission', 'Engine'],
    open: false,
    hours: '11:00 AM – 7:00 PM',
    location: 'DHA Phase 5, Karachi',
    specialty: 'German Cars',
    estimate: 'PKR 8,000 – 35,000',
  },
  {
    id: 'm4',
    name: 'Sana Workshop',
    workshop: 'QuickFix Mobile',
    photo: 'm4',
    verified: true,
    rating: 4.6,
    reviews: 156,
    experience: 6,
    distance: 0.9,
    brands: ['Suzuki', 'Toyota', 'Kia'],
    services: ['Emergency', 'Battery', 'Flat Tyre'],
    open: true,
    hours: '24/7',
    location: 'Johar Town, Lahore',
    specialty: 'Emergency',
    estimate: 'PKR 1,500 – 5,000',
  },
]

export const expenses: Expense[] = [
  { id: 'e1', category: 'Fuel', title: 'PSO Petrol — 32L', amount: 8960, date: 'Today', icon: 'fuel' },
  { id: 'e2', category: 'Service', title: 'Oil change + filter', amount: 6500, date: 'Yesterday', icon: 'wrench' },
  { id: 'e3', category: 'Toll Tax', title: 'M2 Motorway', amount: 850, date: '2 days ago', icon: 'road' },
  { id: 'e4', category: 'Car Wash', title: 'Foam wash — Gulberg', amount: 1200, date: '4 days ago', icon: 'droplets' },
  { id: 'e5', category: 'Parking', title: 'Packages Mall', amount: 200, date: '5 days ago', icon: 'parking' },
]

export const monthlySpend = [
  { label: 'Jan', value: 18500 },
  { label: 'Feb', value: 22100 },
  { label: 'Mar', value: 19800 },
  { label: 'Apr', value: 27400 },
  { label: 'May', value: 24300 },
  { label: 'Jun', value: 31200 },
  { label: 'Jul', value: 28600 },
]

export const categorySpend = [
  { label: 'Fuel', value: 42, color: '#1B4DFF' },
  { label: 'Repairs', value: 22, color: '#FF7A1A' },
  { label: 'Service', value: 18, color: '#10B981' },
  { label: 'Other', value: 18, color: '#94A3B8' },
]

export const serviceTimeline = [
  {
    id: 's1',
    title: 'Full oil change',
    workshop: 'Ali Auto Care',
    mechanic: 'Usman Ali',
    date: '12 Jun 2026',
    cost: 6500,
    parts: ['Synthetic oil 4L', 'Oil filter'],
    warranty: '30 days',
    rating: 5,
  },
  {
    id: 's2',
    title: 'AC gas refill',
    workshop: 'Khan Motors',
    mechanic: 'Bilal Khan',
    date: '03 Mar 2026',
    cost: 4500,
    parts: ['R134a gas'],
    warranty: '15 days',
    rating: 4,
  },
  {
    id: 's3',
    title: 'Front brake pads',
    workshop: 'Ali Auto Care',
    mechanic: 'Usman Ali',
    date: '18 Nov 2025',
    cost: 12500,
    parts: ['Ceramic pads', 'Brake fluid'],
    warranty: '90 days',
    rating: 5,
  },
]

export const tips = [
  {
    en: 'Check tyre pressure before long motorway trips — saves fuel and improves safety.',
    ur: 'لمبی موٹر وے سفر سے پہلے ٹائر پریشر چیک کریں — ایندھن بچے گا اور حفاظت بہتر ہوگی۔',
  },
]
