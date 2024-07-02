import os
import sys

def create_flutter_feature_structure(feature_name):
    # Convert the feature name to lowercase
    feature_name_lower = feature_name.lower()
    
    # Define directory structure
    base_dir = feature_name_lower
    sub_dirs = [
        'data/models', 'data/repository', 'data/sources',
        'domain/models', 'domain/repository', 'domain/use_cases',
        'presentation/block', 'presentation/views'
    ]
    
    # Define files to create with their content
    files = {
        f"{base_dir}/{feature_name_lower}.dart": f"""
export 'data/{feature_name_lower}_data.dart';
export 'domain/{feature_name_lower}_domain.dart';
export 'presentation/{feature_name_lower}_presentation.dart';
""",
        f"{base_dir}/data/{feature_name_lower}_data.dart": f"""
export 'repository/{feature_name_lower}_repository_impl.dart';
""",
        f"{base_dir}/domain/{feature_name_lower}_domain.dart": f"""
export 'repository/{feature_name_lower}_repository.dart';
""",
        f"{base_dir}/presentation/{feature_name_lower}_presentation.dart": f"""
export 'views/{feature_name_lower}_views.dart';
//export 'bloc/{feature_name_lower}_bloc.dart';
""",

        f"{base_dir}/presentation/views/{feature_name_lower}_page.dart": f"""import 'package:flutter/material.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';

class {feature_name.capitalize()}Page extends StatelessWidget {{
    const {feature_name.capitalize()}Page({{super.key}});

    @override
    Widget build(BuildContext context) {{
        return Scaffold(
            appBar: AppBar(
                title: const Text('{feature_name.capitalize()}'),
                elevation: 6,
            ),
            drawer: const DrawerCustom(
                indexInitial: x,
            ),
            body: const Center(
                child: Text('Welcome to {feature_name.capitalize()}'),
            ),
        );
    }}
}}
""",
        f"{base_dir}/presentation/views/{feature_name_lower}_views.dart": f"export '{feature_name_lower}_page.dart';",
        f"{base_dir}/domain/repository/{feature_name_lower}_repository.dart":  f"""
abstract class {feature_name.capitalize()}Repository{{
}}
""",
        f"{base_dir}/data/repository/{feature_name_lower}_repository_impl.dart": f"""
import '../../domain/repository/{feature_name_lower}_repository.dart';

class {feature_name.capitalize()}RepositoryImpl implements {feature_name.capitalize()}Repository {{
}}
"""
    }

    # Create directories
    for sub_dir in sub_dirs:
        os.makedirs(os.path.join(base_dir, sub_dir), exist_ok=True)

    # Create files with content
    for file_path, content in files.items():
        with open(file_path, 'w') as file:
            file.write(content)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python create_flutter_structure.py <feature_name>")
        sys.exit(1)

    feature_name = sys.argv[1]
    create_flutter_feature_structure(feature_name)
    print(f"Flutter feature structure for '{feature_name}' created successfully.")

