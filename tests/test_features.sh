#!/bin/bash

echo "═══════════════════════════════════════════════════════════════════════════════"
echo "                   SpyGraph - Feature Testing                                  "
echo "═══════════════════════════════════════════════════════════════════════════════"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "\n${YELLOW}[Test 1]${NC} Checking spygraph command..."
if command -v spygraph &> /dev/null; then
    echo -e "${GREEN}✓${NC} spygraph command found"
else
    echo -e "${RED}✗${NC} spygraph command not found"
    echo "  Run: pip install -e ."
    exit 1
fi

echo -e "\n${YELLOW}[Test 2]${NC} Testing create_account command..."
spygraph create_account --help > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} create_account subcommand available"
else
    echo -e "${RED}✗${NC} create_account subcommand failed"
    exit 1
fi

echo -e "\n${YELLOW}[Test 3]${NC} Testing run command..."
spygraph run --help > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓${NC} run subcommand available"
else
    echo -e "${RED}✗${NC} run subcommand failed"
    exit 1
fi

echo -e "\n${YELLOW}[Test 4]${NC} Testing Telegraph API connectivity..."
if timeout 3 curl -s "https://api.telegra.ph/getPageList?access_token=test" > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Telegraph API reachable"
else
    echo -e "${RED}✗${NC} Telegraph API not reachable"
    echo "  This might be a network issue"
fi

echo -e "\n${YELLOW}[Test 5]${NC} Testing account creation..."
ACCOUNT_NAME="testaccount$(date +%s)"
OUTPUT=$(spygraph create_account --name "$ACCOUNT_NAME" 2>&1)

if echo "$OUTPUT" | grep -q "Access Token"; then
    echo -e "${GREEN}✓${NC} Account created successfully"
    TOKEN=$(echo "$OUTPUT" | grep "Access Token" | head -1 | awk '{print $NF}')
    echo "  Token: ${TOKEN:0:16}..."
else
    echo -e "${RED}✗${NC} Account creation failed"
    echo "$OUTPUT"
    exit 1
fi

echo -e "\n${YELLOW}[Usage Examples]${NC}"
echo ""
echo "Create an account:"
echo "  spygraph create_account --name myaccount --author-name 'Your Name'"
echo ""
echo "Run tracking server with auto-account creation:"
echo "  spygraph run --domain tracking.example.com"
echo ""
echo "Run with existing token:"
echo "  spygraph run --domain tracking.example.com --telegraph-token YOUR_TOKEN"
echo ""
echo "Use custom Telegraph mirror:"
echo "  spygraph run --domain tracking.example.com --domain-graph custom-mirror.com"
echo ""

echo -e "\n${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}All tests passed! SpyGraph is ready to use.${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════════════════════${NC}\n"
