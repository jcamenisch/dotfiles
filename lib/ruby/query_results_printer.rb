# Takes an ActiveRecord::Result object, and prints it in db-console style
#
# Usage:
#
#   results = ActiveRecord::Base.connection.select("select name, email, created_at, updated_at from users limit 10")
#   QueryResultsPrinter.new(results).print
#
# Output:
#
# +----------------+----------------------+-------------------------+-------------------------+
# | name           | email                | created_at              | updated_at              |
# +----------------+----------------------+-------------------------+-------------------------+
# | John Wayne     | jwayne@example.com   | 2015-01-11 02:59:46 UTC | 2016-04-03 02:30:04 UTC |
# | Charlie Horse  | chorse@example.com   | 2015-01-16 23:54:38 UTC | 2016-04-13 16:53:27 UTC |
# | Sue Gorlie     | sgorlie@example.com  | 2015-01-22 01:14:03 UTC | 2015-11-27 00:55:24 UTC |
# | Humpty Dumpty  | hdumpty@example.com  | 2015-01-22 02:14:07 UTC | 2015-10-01 12:00:11 UTC |
# | Betty Nesbitt  | bnesbitt@example.com | 2015-01-22 02:55:45 UTC | 2015-09-25 07:31:26 UTC |
# | Jane Doe       | jdoe@example.co.nz   | 2015-01-22 03:44:06 UTC | 2016-01-05 23:05:41 UTC |
# | Jordan Smith   | jsmith@example.net   | 2015-01-22 08:58:09 UTC | 2015-06-01 02:00:16 UTC |
# | Wanda Lane     | wlane@example.net    | 2015-01-22 09:13:14 UTC | 2016-02-02 16:00:11 UTC |
# | Tessa Bryan    | tbryan@example.com   | 2015-01-22 09:55:13 UTC | 2016-01-07 10:00:55 UTC |
# | Terry Anderson | tanderson@example.ru | 2015-01-22 11:05:16 UTC | 2015-11-27 00:55:24 UTC |
# +----------------+----------------------+-------------------------+-------------------------+
#
class QueryResultsPrinter
  attr_reader :results, :column_widths

  def initialize(query_results)
    @results = query_results

    @column_widths = {}

    columns.each do |col|
      @column_widths[col] = col.length

      results.each do |row|
        # We're going to treat all the values as strings, so just convert them all upfront.
        row[col] = row[col].to_s

        if row[col].length > @column_widths[col]
          @column_widths[col] = row[col].length
        end
      end
    end
  end

  def columns
    results.columns
  end

  def fmt_row(row, sep: '|', space: ' ')
    sep.dup.tap do |ret|
      row.each do |col, value|
        ret << "#{space}#{value.ljust(column_widths[col], space)}#{space}#{sep}"
      end
    end
  end

  def rule
    # Pass a hash with all column keys, with empty strings as values.
    @rule ||= fmt_row(Hash[columns.map{|c| [c, '']}], sep: '+', space: '-')
  end

  def headers
    # Pass a hash of all column keys, with empty strings as values.
    @headers ||= fmt_row(Hash[columns.map{|c| [c, c]}])
  end

  def print
    puts rule
    puts headers
    puts rule

    results.each do |row|
      puts fmt_row(row)
    end

    puts rule
  end
end

# MIT LICENSE
#
# Copyright (c) 2016 Jonathan Camenisch
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
