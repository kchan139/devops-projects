import os
import tarfile
import argparse
from datetime import datetime

def archive_logs(log_dir: str):
    """
    Archives logs from a specified directory into a compressed tar.gz file

    Args:
        log_dir(str): the path to the logs directory
    """
    if not os.path.isdir(log_dir):
        print(f"Error: Log directory {log_dir} not found")
        return
    
    archive_dir = os.path.join(log_dir, 'archive')
    os.makedirs(archive_dir, exist_ok=True)

    timestamp = datetime.now().strftime('%d%m%Y_%H%M%S')
    archive_filename = f'logs_archive_{timestamp}.tar.gz'
    archive_path = os.path.join(archive_dir, archive_filename)

    try:
        with tarfile.open(archive_path, 'w:gz') as tar:
            tar.add(log_dir, arcname=os.path.basename(log_dir))

    except Exception as e:
        print(f'Error achiving: {e}')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Archive logs by compressing them into a tar.gz file')
    parser.add_argument('log_dir', help='Path to the logs directory')

    args = parser.parse_args()

    archive_logs(args.log_dir)