# KIN241 Next.js Application

A simple Next.js application for KIN241 infrastructure project.

## Features

- **Next.js 14** with App Router
- **TypeScript** support
- **Tailwind CSS** for styling
- **Docker** containerization
- **Azure App Service** deployment ready

## Quick Start

### Development

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

### Docker

```bash
# Build Docker image
docker build -t kin241-nextjs-app .

# Run locally
docker run -p 3000:3000 kin241-nextjs-app

# Build and push to Azure Container Registry
./build-and-push.sh dev v1.0.0
```

## Deployment

### Azure App Service

This app is configured to deploy to Azure App Service using:

1. **Container deployment** from Azure Container Registry
2. **VNet integration** for secure networking
3. **Private endpoint** for internal access
4. **Application Gateway** for load balancing
5. **Azure Front Door** for global distribution

### Infrastructure

The app integrates with the KIN241 Bicep infrastructure:

- **App Service Plan**: PremiumV2 with auto-scaling
- **VNet Integration**: Secure outbound connections
- **Private Endpoint**: Internal network access
- **Application Gateway**: Layer 7 load balancing with WAF
- **Azure Front Door**: Global CDN and load balancing

## Architecture

```
Internet → Azure Front Door → Application Gateway → App Service (Next.js)
                ↓                    ↓                    ↓
            Global CDN          WAF Protection      Container Runtime
            Load Balancing      SSL Termination     VNet Integration
```

## Environment Variables

- `NODE_ENV`: Production environment
- `PORT`: Application port (3000)
- `WEBSITE_VNET_ROUTE_ALL`: Enable VNet routing
- `WEBSITE_DNS_SERVER`: DNS server configuration

## Security

- **HTTPS only** access
- **VNet integration** for secure networking
- **Private endpoint** for internal access
- **WAF protection** at Application Gateway level
- **No public direct access** to App Service

## Monitoring

- **Application Insights** integration
- **Auto-scaling** based on CPU usage
- **Health probes** for load balancer
- **Performance monitoring** through Azure Monitor
