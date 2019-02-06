Deface::Override.new(
    virtual_path: "spree/admin/shared/_settings_sub_menu",
    name: "fb_catalog_admin_sidebar_menu",
    insert_bottom: "[data-hook='admin_settings_sub_tabs']",
    partial: 'spree/admin/shared/fb_catalog_sidebar_menu'
)