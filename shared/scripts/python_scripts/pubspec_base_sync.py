import glob
import os

import ruamel.yaml

yaml = ruamel.yaml.YAML()


def main():
    dirname = os.path.dirname(__file__)
    base_path = os.path.join(dirname, '../../pubspec_dependencies.yaml')

    with open(base_path, 'r') as base_file:
        base = yaml.load(base_file)

    for path in glob.glob(os.path.join(dirname, '../../packages/**/pubspec.yaml'), recursive=True):
        print(f'\n\nUpdating {path}')

        with open(path, 'r') as read_file:
            content = yaml.load(read_file)
            content = sync_content(base, content)

        with open(path, 'w') as write_file:
            yaml.dump(content, write_file)


def sync_content(base, content):
    for key_base, value_base in base.items():
        if content is not None and key_base in content:
            if key_base == 'dependencies' or key_base == 'dev_dependencies' or key_base == 'dependency_overrides':
                sync_dependencies(value_base, content[key_base])
            if type(value_base) in (str, int, bool, float):
                content[key_base] = value_base
            elif value_base is not None:
                content[key_base] = sync_content(value_base, content[key_base])

    return content


def sync_dependencies(base, content):
    for key_content, value_content in content.copy().items():
        if type(value_content) in (str, int, float):
            if key_content in base:
                content[key_content] = base[key_content]
            else:
                raise Exception(
                    f'Dependency {key_content}:{value_content} not present on base file')


if __name__ == '__main__':
    main()
