/* -------------------------------------------------------------------------------------------- *
 * This file contains `require` directives to javascript files.                                 *
 * All of these javascript files will be compiled into a single javascript file.                *
 * To use this combined stylesheet, include the following in the head section of your views:    *
 *                                                                                              *
 * <%= application :js %>            If including only application.js                           *
 * <%= application :css, :js %>      If including application.css as well                       *
 *                                                                                              *
 * By default, every file in the /assets/scripts directory is required by `require_tree .`.     *
 * However, you may remove the `require_tree .` directive and instead specify individual files. *
 *                                                                                              *
 * Additionally for any global JS code, you can also include it directly in this file.          *
 * -------------------------------------------------------------------------------------------- *
 *= require_self
 *= require_tree .
 */