require 'csv'

class PopulationImporter
  HEADERS = ["DEMO_IND","Indicator","LOCATION","Country","TIME","Time","Value","Flag Codes","Flags"]
  INDICATOR = "Population aged 25-64 years "

  attr_accessor :filepath

  def initialize(filepath)
    @filepath = filepath
    import_working_population
  end

  def import_working_population
    CSV.foreach(filepath, { col_sep: ",", quote_char:"\"", headers: true }) do |row|
      if row["Indicator"] == INDICATOR && COUNTRIES.include?(row["LOCATION"])
        record = Data.find_or_initialize_by(
          type: "WorkingPopulation",
          country_code: row["LOCATION"],
          year: row["TIME"])
        record.value = row["Value"]
        record.save
      end
    end
  end
end
