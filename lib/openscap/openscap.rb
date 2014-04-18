#
# Copyright (c) 2014 Red Hat Inc.
#
# This software is licensed to you under the GNU General Public License,
# version 2 (GPLv2). There is NO WARRANTY for this software, express or
# implied, including the implied warranties of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. You should have received a copy of GPLv2
# along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
#

require 'ffi'

module OpenSCAP
  extend FFI::Library
  ffi_lib 'openscap'

  def self.error?
    return oscap_err()
  end

  def self.get_full_error
    err = oscap_err_get_full_error
    return err.null? ? nil : err.read_string()
  end

  def self.raise!
    err = get_full_error
    if err.nil?
      err = '(unknown error)'
    end
    raise OpenSCAPError, err
  end

  attach_function :oscap_init, [], :void
  attach_function :oscap_cleanup, [], :void
  attach_function :oscap_get_version, [], :string

  attach_function :oscap_err, [], :bool
  attach_function :oscap_err_get_full_error, [], :pointer
  private_class_method :oscap_err, :oscap_err_get_full_error
end