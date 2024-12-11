import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

// CSS Imports
import './styles.css';
import './themes/catppuccin-frappe.css';

// Main Layout / App
import AppLayout from './layout';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <AppLayout />
    </StrictMode>
);
