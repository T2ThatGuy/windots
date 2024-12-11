import { ReactNode } from 'react';
import { cn } from '../utils';

export default function Group({
    children,
    alignment,
    innerClass,
}: {
    children: ReactNode;
    alignment: 'start' | 'center' | 'end';
    innerClass: string;
}) {
    return (
        <div
            className={cn(
                'flex w-fit h-full items-center p-1',
                `justify-self-${alignment}`
            )}
        >
            <div className={cn('flex flex-row items-center', innerClass)}>
                {children}
            </div>
        </div>
    );
}
