import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { BrowserAgent } from '@newrelic/browser-agent/loaders/browser-agent'
import { Spa }          from '@newrelic/browser-agent/features/spa'


console.log('[NewRelic] Starting BrowserAgent…');
export const nr = new BrowserAgent({
    info: {
        licenseKey:    import.meta.env.VITE_NEW_RELIC_BROWSER_KEY, // «Ingest – Browser»
        applicationID: import.meta.env.VITE_NEW_RELIC_APP_ID       // ID numérico
    },
    features: [Spa],                // activa medición SPA (route-changes)
    init: {                          // ajustes opcionales
        distributed_tracing: { enabled: true }
    }
})
console.log('[NewRelic] BrowserAgent started');

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)


