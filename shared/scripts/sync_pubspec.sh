cd ./scripts/python_scripts || exit
python3 -m venv ./py_venv
py_venv/bin/pip install ruamel.yaml
py_venv/bin/python pubspec_base_sync.py