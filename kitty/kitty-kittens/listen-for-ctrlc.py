from kitty.boss import get_boss
from kitty.fast_data_types import get_selection

def main(args):
    return 'pass'

def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    # Cek apakah ada teks diseleksi
    if window.selection:
        window.copy_selection_to_clipboard()
    else:
        window.send_text('\x03')  # Kirim Ctrl+C (SIGINT)
