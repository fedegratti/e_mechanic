require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { brand: @car.brand, chassis_number: @car.chassis_number, client_id: @car.client_id, engine_number: @car.engine_number, kilometers: @car.kilometers, model: @car.model, plate: @car.plate, sell_date: @car.sell_date } }
    end

    assert_redirected_to car_url(Car.last)
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  test "should update car" do
    patch car_url(@car), params: { car: { brand: @car.brand, chassis_number: @car.chassis_number, client_id: @car.client_id, engine_number: @car.engine_number, kilometers: @car.kilometers, model: @car.model, plate: @car.plate, sell_date: @car.sell_date } }
    assert_redirected_to car_url(@car)
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end
end
