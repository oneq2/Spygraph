import random
import string


def random_token(length=16) -> str:
    chars = string.ascii_letters + string.digits
    return "".join(random.choice(chars) for _ in range(length))

def get_fingerprint() -> dict[str, str]:
    fingerprints = [
        {"Server": "nginx/1.24.0", "X-Powered-By": ""},
        {"Server": "nginx/1.18.0", "X-Powered-By": ""},
        {"Server": "Apache/2.4.58", "X-Powered-By": "PHP/8.1"},
        {"Server": "Apache/2.4.50", "X-Powered-By": "PHP/7.4"},
        {"Server": "Express", "X-Powered-By": "Express"},
        {"Server": "Express.js", "X-Powered-By": "Node.js"},
        {"Server": "Microsoft-IIS/10.0", "X-Powered-By": "ASP.NET"},
        {"Server": "LiteSpeed", "X-Powered-By": "PHP/8.0"},
        {"Server": "Cloudflare", "X-Powered-By": ""},
        {"Server": "gunicorn", "X-Powered-By": "Python"},
        {"Server": "Uvicorn", "X-Powered-By": "FastAPI"},
        {"Server": "TornadoServer", "X-Powered-By": "Python"},
        {"Server": "Werkzeug", "X-Powered-By": "Flask"},
    ]

    selected = random.choice(fingerprints)
    # Фильтруем пустые значения
    return {k: v for k, v in selected.items() if v}