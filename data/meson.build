icon_sizes = ['32', '48', '64', '128']

foreach i : icon_sizes
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

i18n.merge_file(
    input: meson.project_name() + '.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

i18n.merge_file(
    input: meson.project_name() + '.appdata.xml.in',
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

install_data(
    join_paths('sounds', 'bomb.mp3'),
    install_dir : join_paths('share', 'goldsearch', 'sounds'))

install_data(
    join_paths('sounds', 'coins.mp3'),
    install_dir : join_paths('share', 'goldsearch', 'sounds'))

install_data(
    join_paths('images', '1.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))

install_data(
    join_paths('images', '2.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))

install_data(
    join_paths('images', '3.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))

install_data(
    join_paths('images', '4.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))

install_data(
    join_paths('images', '5.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))

install_data(
    join_paths('images', 'barrel.png'),
    install_dir : join_paths('share', 'goldsearch', 'images'))