// src/__tests__/App.test.tsx
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import App from '../App';

describe('<App />', () => {
    it('renders the heading', () => {
        render(<App />);
        const heading = screen.getByRole('heading', { level: 1 });
        expect(heading).toHaveTextContent(/vite \+ react/i);
    });
});
