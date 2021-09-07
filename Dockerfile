# Stage 1: Compile and Build the app

# Node veersion
FROM node:14.17.6-alpine as build

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat git

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY ./* /app/

# Production image, copy all the files and run next
FROM node:14.17.6-alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

CHOWN nextjs:nodejs ./.next ./.next

USER nextjs

EXPOSE 3000

CMD ["yarn", "start:prod"]