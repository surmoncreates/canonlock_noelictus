import os, json, yaml, hashlib, time
REG_YML = "canon/canonlock_registry.yml"
OUT_DIR = "scripts/generated"
os.makedirs(OUT_DIR, exist_ok=True)
def load_yaml(path):
    with open(path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)
def write_json(path, data):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
def digest_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        h.update(f.read())
    return h.hexdigest()
def main():
    if os.path.exists(REG_YML):
        registry = load_yaml(REG_YML)
    else:
        registry = {"meta":{"version":"0.0","note":"registry file missing"}, "characters":[], "factions":[], "abilities":[], "artifacts":[]}
    problems = []
    for key in ("characters","factions","abilities","artifacts"):
        if key not in registry:
            registry[key] = []
            problems.append(f"Missing '{key}' in registry; created empty list.")
    reg_json_path = os.path.join(OUT_DIR, "canonlock_registry.json")
    write_json(reg_json_path, registry)
    manifest = {
        "built_at": int(time.time()),
        "source_registry": REG_YML if os.path.exists(REG_YML) else None,
        "source_digest": digest_file(REG_YML) if os.path.exists(REG_YML) else None,
        "warnings": problems,
        "counts": {k: len(registry.get(k, [])) for k in ("characters","factions","abilities","artifacts")}
    }
    write_json(os.path.join(OUT_DIR, "manifest.json"), manifest)
if __name__ == "__main__":
    main()
