import { type ClassValue, clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export const IS_LAPTOP = import.meta.env.VITE_LAPTOP_MODE !== '';

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs));
}
