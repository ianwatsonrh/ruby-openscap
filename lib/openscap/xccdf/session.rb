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

module OpenSCAP
  module Xccdf

    class Session
      def initialize(input_filename)
        @input_filename = input_filename
        @s = OpenSCAP.xccdf_session_new(input_filename)
        if @s.null?
          OpenSCAP.raise!
        end
      end

      def load
        if OpenSCAP.xccdf_session_load(@s) != 0
          OpenSCAP.raise!
        end
      end

      def finalize(s)
        OpenSCAP.xccdf_session_free(s.s)
      end
    end

  end
  attach_function :xccdf_session_new, [:string], :pointer
  attach_function :xccdf_session_free, [:pointer], :void
  attach_function :xccdf_session_load, [:pointer], :int
end